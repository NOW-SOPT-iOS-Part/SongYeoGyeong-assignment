//
//  PagingTabBarCell.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 5/4/24.
//

import UIKit
import SnapKit

class PagingTabBarCell: UICollectionViewCell {
    static let identifier = "PagingTabBarCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 17.0)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var underline: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.0
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            underline.alpha = isSelected ? 1.0 : 0.0
        }
    }
    
    func setupView(title: String) {
        setupLayout()
        titleLabel.text = title
    }
}

private extension PagingTabBarCell {
    func setupLayout() {
        [titleLabel, underline].forEach { addSubview($0) }
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        underline.snp.makeConstraints { make in
            make.height.equalTo(3.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(7.0)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
