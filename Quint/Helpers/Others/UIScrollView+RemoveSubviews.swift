//
//  UIScrollView+RemoveSubviews.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/10/22.
//

import Foundation
import UIKit

extension UIScrollView{
    func removeSubViews(){
        for view in self.subviews{
            view.removeFromSuperview()
        }
    }
}
