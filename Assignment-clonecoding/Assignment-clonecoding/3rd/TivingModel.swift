//
//  TivingModel.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 4/30/24.
//

import UIKit

struct ItemModel {
    let itemImg: UIImage
    let name: String

}

extension ItemModel {
    static func dummy() -> [ItemModel] {
        return [
            ItemModel(itemImg: .poster2Signal, name: "시그널"),
            ItemModel(itemImg: .poster3Harry, name: "해리포터와 마법사의 돌"),
            ItemModel(itemImg: .poster4Ring, name: "반지의 제왕"),
            ItemModel(itemImg: .poster5Door, name: "스즈메의 문단속"),
            ItemModel(itemImg: .poster2Signal, name: "시그널"),
            ItemModel(itemImg: .poster3Harry, name: "해리포터와 마법사의 돌"),
            ItemModel(itemImg: .poster4Ring, name: "반지의 제왕"),
            ItemModel(itemImg: .poster5Door, name: "스즈메의 문단속")
        ]
    }
}


