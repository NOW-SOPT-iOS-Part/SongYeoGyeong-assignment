//
//  Extension.swift
//  Assignment-clonecoding
//
//  Created by 송여경 on 6/7/24.
//
import UIKit

extension UIColor {
    static let gray0 = UIColor(red: 0/255, green:0/255, blue: 0/255, alpha: 1)
    static let gray46 = UIColor(red: 46/255, green:46/255, blue: 46/255, alpha: 1)
    static let gray98 = UIColor(red: 98/255, green:98/255, blue: 98/255, alpha: 1)
    static let gray156 = UIColor(red: 156/255, green:156/255, blue: 156/255, alpha: 1)
    static let gray214 = UIColor(red: 214/255, green:214/255, blue: 214/255, alpha: 1)
}

extension UIFont{
    enum Pretendard{
        case thin
        case extraLight
        case light
        case regular
        case medium
        case semiBold
        case bold
        case extraBold
        case black
        
        var name : String{
            switch self{
            case .thin:
                return "Pretendard-Thin"
            case .extraLight:
                return "Pretendard-ExtraLight"
            case .light:
                return "Pretendard-Light"
            case .regular:
                return "Pretendard-Regular"
            case .medium:
                return "Pretendard-Medium"
            case .semiBold:
                return "Pretendard-SemiBold"
            case .bold:
                return "Pretendard-Bold"
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .black:
                return "Pretendard-Black"
            }
        }
    }
    static func pretendard(_ weight: Pretendard, size: CGFloat) -> UIFont {
        return UIFont(name: weight.name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}


