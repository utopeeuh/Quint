//
//  StatusBarStyle.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 24/11/22.
//

import Foundation
import UIKit

extension UITabBarController {
   open override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }
}

extension UINavigationController {
   open override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}
