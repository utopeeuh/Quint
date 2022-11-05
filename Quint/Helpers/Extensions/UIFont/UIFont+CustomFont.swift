//
//  UIFont+CustomFont.swift
//  Quint
//
//  Created by Vendly on 06/10/22.
//

import UIKit

extension UIFont {
    
    static func interRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Inter-Regular", size: size)
    }
    
    static func interMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "Inter-Medium", size: size)
    }
    
    static func interSemiBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Inter-SemiBold", size: size)
    }
    
    static func clashGroteskMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "ClashGrotesk-Medium", size: size)
    }
    
}
