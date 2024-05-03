//
//  HomeController.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/30/24.
//

import UIKit

final class HomeController: UIViewController {
    final let movieLineSpacing: CGFloat = 6
    final let cellHeight: CGFloat = 173
    final let movieInset = UIEdgeInsets(top: 48, left: 30, bottom: 42, right: 6)
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let titleMovie: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "poster1")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        setLayout()
        register()
        setDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    private func setLayout(){
        self.view.addSubview(collectionView)
    }
    
    private func register() {
        collectionView.register(
            HomeCollectionView.self,
            forCellWithReuseIdentifier: HomeCollectionView.identifier
        )
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// UICollectionViewDelegateFlowLayout, UICollectionViewDataSource 프로토콜 익스텐션 추가
extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 4
        let totalSpacing: CGFloat = movieInset.left + movieInset.right + movieLineSpacing * (numberOfColumns - 1)
        let adjustedWidth = (collectionView.bounds.width - totalSpacing) / numberOfColumns
        return CGSize(width: adjustedWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return movieLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return movieLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return movieInset
    }
}

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemModel.dummy().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionView.identifier, for: indexPath) as? HomeCollectionView else {
            fatalError("Unable to dequeue HomeCollectionView")
        }
        let item = ItemModel.dummy()[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}
