//
//  MultipleSubview.swift
//  Quint
//
//  Created by Vendly on 18/10/22.
//

import UIKit

extension UIView {
    
    func multipleSubviews(view: UIView...) {
        for v in view {
            addSubview(v)
        }
    }
    
}
