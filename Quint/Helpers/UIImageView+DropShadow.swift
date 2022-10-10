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
        self.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.22).cgColor
        self.layer.shadowOpacity = 25
        self.layer.shadowOffset = CGSize(width: 10, height: 20)
        self.layer.shadowRadius = 15
        
    }
    
}
