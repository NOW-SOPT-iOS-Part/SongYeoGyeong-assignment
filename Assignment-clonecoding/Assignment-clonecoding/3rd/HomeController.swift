//
//  HomeController.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/30/24.
//

import UIKit
import SnapKit

final class HomeController: UIViewController, UICollectionViewDelegate {
    private let categoryTitleList = ["홈", "실시간", "TV프로그램","영화","파라마운트+"]
    private var itemData = ItemModel.dummy()

    private lazy var pagingTabBar = PagingTabBar(categoryTitleList: categoryTitleList)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private let contentView = UIView()
    
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
    
    private lazy var fulldisplayButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체보기 >", for: .normal)
        button.setTitleColor(.systemGray3, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Mediud", size: 17)
        return button
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "티빙에서 꼭 봐야 하는 콘텐츠"
        label.font = UIFont(name: "Pretendard-SemiBol", size: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 98, height: 146)
            layout.minimumLineSpacing = 8
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 8)

            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.showsHorizontalScrollIndicator = true
            collectionView.backgroundColor = .clear
            return collectionView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        setupLayout()
        register()
        setDelegate()
    }
    
    private func register(){
        collectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieCollectionViewCell.identifier
        )
    }
    private func setDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

private extension HomeController {
    func setupLayout() {
        navigationController?.isNavigationBarHidden = true
        [pagingTabBar].forEach { view.addSubview($0) }
        [movieImageView, tivingImageView, profileImageView, contentLabel, fulldisplayButton, collectionView].forEach { contentView.addSubview($0) }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1000)
        }
        
        movieImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(520)
        }
        
        tivingImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(58)
            $0.left.equalToSuperview().offset(11)
            $0.width.equalTo(99)
            $0.height.equalTo(25)
        }
        
        profileImageView.snp.makeConstraints {
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
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(15)
        }
        
        fulldisplayButton.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(15)
            $0.trailing.equalToSuperview().offset(-12)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }
    }
}


extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }

        // 셀에 데이터 바인딩
        let item = itemData[indexPath.item]
        cell.dataBind(item)

        return cell
    }
}
