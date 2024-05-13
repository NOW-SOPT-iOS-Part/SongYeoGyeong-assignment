//
//  MovieCollectionViewCell.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 5/6/24.
//

import UIKit
import SnapKit

protocol MovieCollectionDelegate: AnyObject {
    func didTapMovieCell(_ index: Int)
}

class MovieCollectionViewCell: UICollectionViewCell {
    // 셀 식별자
    static let identifier = "MovieCollectionViewCell"
    
    weak var delegate: MovieCollectionDelegate?
    
    private let movieImageView = UIImageView()
    
    private let movieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Medium", size: 10)
        return label
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           
           self.backgroundColor = .white
           setLayout()
       }
       
       @available(*, unavailable)
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    private func setLayout(){
        [movieImageView, movieLabel].forEach {
                    contentView.addSubview($0)
                }
        movieLabel.snp.makeConstraints{
            $0.top.equalTo(movieImageView.snp.bottom).offset(3)
        }
        movieImageView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
    }
}
extension MovieCollectionViewCell {
    func dataBind(_ itemData: ItemModel) {
        movieImageView.image = itemData.itemImg
        movieLabel.text = itemData.name
    }
    
}
extension MovieCollectionViewCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate{
            delegate.didTapMovieCell(indexPath.item)
        }
    }
}
