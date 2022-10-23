//
//  UIImageView+DropShadow.swift
//  Quint
//
//  Created by Vendly on 05/10/22.
//

import UIKit

extension UIImageView {
    
    func dropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = K.Color.greyQuint.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 14, height: 36)
        self.layer.shadowRadius = 38

    }
    
}
