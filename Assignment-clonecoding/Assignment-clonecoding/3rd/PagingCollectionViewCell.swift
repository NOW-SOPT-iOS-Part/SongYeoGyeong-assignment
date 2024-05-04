//
//  PagingCollectionViewCell.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 5/4/24.
//

import UIKit
import SnapKit

class PagingCollectionViewCell: UICollectionViewCell {
    static let identifier = "PagingCollectionViewCell"
    
//화면 전환 시 배경색만 변화되도록 했다. 
    func setupView() {
        
        setupLayout()
        self.backgroundColor = .black
    }
    
    private func setupLayout(){
        
    }

}
