//
//  HomeController.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/30/24.
//

import UIKit
import SnapKit

final class HomeController: UIViewController {
    private let categoryTitleList = ["홈", "실시간", "TV프로그램","영화","파라마운트+"]
    
    private lazy var pagingTabBar = PagingTabBar(categoryTitleList: categoryTitleList)
    
    // private lazy var pagingView = PagingView(categoryTitleList: categoryTitleList, pagingTabBar: pagingTabBar)
    //페이지를 넘겨주기 위해 설정해줌.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private let tivingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tivingupside")
        return imageView
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile1")
        return imageView
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "poster1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}

private extension HomeController {
    func setupLayout() {
        navigationController?.isNavigationBarHidden = true
        
        [movieImageView, pagingTabBar, tivingImageView, profileImageView].forEach { view.addSubview($0) }
        
        movieImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(520)
        }
        
        tivingImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(58)
            $0.left.equalToSuperview().offset(11)
            $0.width.equalTo(99)
            $0.height.equalTo(25)
        }
        
        profileImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(55)
            $0.right.equalToSuperview().offset(-9)
            $0.width.equalTo(33)
            $0.height.equalTo(31)
        }
        
        pagingTabBar.snp.makeConstraints {
            $0.top.equalTo(tivingImageView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(7)
            $0.height.equalTo(pagingTabBar.cellHeight)
        }
        
//        pagingView.snp.makeConstraints {
//            $0.top.equalTo(pagingTabBar.snp.bottom)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(200)
//        }
    }
}
