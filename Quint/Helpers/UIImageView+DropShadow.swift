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
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 5.0
        self.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        self.layer.shadowRadius = 5.0
        
    }
    
}
