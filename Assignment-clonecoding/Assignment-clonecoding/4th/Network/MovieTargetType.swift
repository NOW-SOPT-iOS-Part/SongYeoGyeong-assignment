//
//  MovieTargetType.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 5/10/24.
//

import Foundation
import Moya

enum MovieTargetType {
    case fetchMovieInfo(requestModel: ModelInfoRequestModel)
}

extension MovieTargetType: TargetType {
    var baseURL: URL { return URL(string: Config.baseURL)! }

    var path: String {
        switch self {
        case .fetchMovieInfo(let requestModel):
            return "/movies/\(requestModel.movieCd)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .fetchMovieInfo:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .fetchMovieInfo(let requestModel):
            return .requestParameters(parameters: ["key": requestModel.key], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
