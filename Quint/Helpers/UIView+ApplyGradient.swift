//
//  UIButton+ApplyGradient.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 10/10/22.
//

import Foundation
import UIKit

extension UIView{
    func applyGradient(colours: [UIColor], locations: [NSNumber]?)
    {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.cornerRadius = 10
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func removeSublayer(layerIndex index: Int) {
        guard let sublayers = self.layer.sublayers else {
            print("The view does not have any sublayers.")
            return
        }
        if sublayers.count > index {
            self.layer.sublayers!.remove(at: index)
        } else {
            print("There are not enough sublayers to remove that index.")
        }
    }
}
