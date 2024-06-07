//
//  MovieInfoService.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 5/10/24.
//
import Foundation
import Moya

final class MovieService {
    static let shared = MovieService()
    private var movieProvider = MoyaProvider<MovieTargetType>(plugins: [MoyaLoggingPlugin()])
    
    private init() {}
}

extension MovieService {
    func fetchMovieInfo(requestModel: ModelInfoRequestModel, completion: @escaping (NetworkResult<Any>) -> Void) {
        movieProvider.request(.fetchMovieInfo(requestModel: requestModel)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, MovieInfoResponseModel.self)
                completion(networkResult)
                
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    // Similar to the judgeStatus function in UserService
    public func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        switch statusCode {
        case 200..<300:
            return isValidData(data: data, T.self)
        case 400..<500:
            return .requestErr
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    // Similar to the isValidData function in UserService
    private func isValidData<T: Codable>(data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("⛔️\(self)에서 디코딩 오류 발생!")
            return .decodedErr
        }
        
        return .success(decodedData as Any)
    }
}

