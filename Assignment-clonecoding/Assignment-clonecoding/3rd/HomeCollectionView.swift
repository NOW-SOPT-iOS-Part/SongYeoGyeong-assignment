//
//  HomeCollectionView.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/30/24.
//

import UIKit

final class HomeCollectionView: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
        
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.612, green: 0.612, blue: 0.612, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-Medium", size: 10)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1.5),  // 조절 가능

            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configure(with item: ItemModel) {
        movieImageView.image = item.itemImg
        titleLabel.text = item.name
    }
}
