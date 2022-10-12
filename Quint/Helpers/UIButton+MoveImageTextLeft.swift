//
//  File.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 12/10/22.
//

import Foundation
import UIKit

extension UIButton {
    func moveImageLeftTextCenter(imagePadding: CGFloat = 30.0){
        guard let imageViewWidth = self.imageView?.frame.width else{return}
        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
        self.contentHorizontalAlignment = .left
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageViewWidth / 2 + 20, bottom: 0.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: titleLabelWidth / 2 - imageViewWidth - 11, bottom: 0.0, right: 0.0)
    }
}
