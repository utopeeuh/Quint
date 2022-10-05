//
//  Extentions.swift
//  DynamicCell
//
//  Created by Mohannad on 28.03.2021.
//

import UIKit
extension UICollectionView {
    
    func toggleActivityIndicator()  {
        
        if let indicator = backgroundView as? UIActivityIndicatorView {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
        else {
            let indicator = UIActivityIndicatorView()
            indicator.style = UIActivityIndicatorView.Style.large
            indicator.color = K.Color.red
            indicator.hidesWhenStopped = true
            backgroundView = indicator
            indicator.startAnimating()
        }
    }
}












