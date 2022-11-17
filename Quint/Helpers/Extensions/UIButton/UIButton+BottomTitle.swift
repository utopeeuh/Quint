//
//  UIButton+BottomTitle.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 17/11/22.
//

import Foundation
import UIKit

extension UIButton {
    
    func alignVertical(spacing: CGFloat = 6.0) {
           guard let imageSize = self.imageView?.image?.size,
               let text = self.titleLabel?.text,
               let font = self.titleLabel?.font
               else { return }
           self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
           let labelString = NSString(string: text)
            let titleSize = labelString.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: font])
           self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
           let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
           self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
       }
    
}
