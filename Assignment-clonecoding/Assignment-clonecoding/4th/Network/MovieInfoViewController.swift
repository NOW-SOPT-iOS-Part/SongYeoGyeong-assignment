//
//  MovieInfoView.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 5/10/24.
//

import UIKit
import SnapKit
import Moya


class MovieInfoView: UIView {
    
    private let contentView = UIView()
    
    private let movieCd = UILabel()
    private let movieNm = UILabel()
    private let prdtYear = UILabel()
    private let showTm = UILabel()
    private let directors = UILabel()
    lazy var movieSelect = 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [movieCd, movieNm, prdtYear, showTm, directors].forEach {
            contentView.addSubview($0)
            $0.font = UIFont(name: "Pretendard-SemiBold", size: 24)
            $0.numberOfLines = 0
        }
        
        addSubview(contentView)
        contentView.backgroundColor = .red
    }
    
    private func setupLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        movieCd.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        movieNm.snp.makeConstraints {
            $0.top.equalTo(movieCd.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        prdtYear.snp.makeConstraints {
            $0.top.equalTo(movieNm.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        showTm.snp.makeConstraints {
            $0.top.equalTo(prdtYear.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        directors.snp.makeConstraints {
            $0.top.equalTo(showTm.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    func configure(with movieInfo: MovieInfoResponseModel) {
        movieCd.text = "Code: \(movieInfo.MovieCd)"
        movieNm.text = "Name: \(movieInfo.movieNm)"
        prdtYear.text = "Year: \(movieInfo.prdtYear)"
        showTm.text = "Duration: \(movieInfo.showTm) min"
        directors.text = "Directors: \(movieInfo.directors)"
    }
    
    
}
final class MovieInfoViewController: UIViewController {
    
    var movieId: Int?  // 영화 ID를 저장할 변수
    private let movieInfoView = MovieInfoView()
    private let movieProvider = MoyaProvider<MovieTargetType>(plugins: [MoyaLoggingPlugin()])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(movieInfoView)
        movieInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        fetchMovieInfo()
    }
    
    private func fetchMovieInfo() {
        guard let movieId = movieId, let apiKey = Bundle.main.apiKey else { return }
        
        let requestModel = ModelInfoRequestModel(key: apiKey, movieCd: String("20124079"))

        
        movieProvider.request(.fetchMovieInfo(requestModel: requestModel)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    do {
                        let movieInfo = try JSONDecoder().decode(MovieInfoResponseModel.self, from: response.data)
                        self?.movieInfoView.configure(with: movieInfo)
                    } catch {
                        print("Error decoding: \(error)")
                    }
                case .failure(let error):
                    print("Error fetching movie info: \(error)")
                }
            }
        }
    }
}
extension Bundle {
    var apiKey: String? {
        return infoDictionary?["API_KEY"] as? String
    }
}
