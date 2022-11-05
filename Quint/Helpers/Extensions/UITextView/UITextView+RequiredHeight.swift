//
//  UITextView+RequiredHeight.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 18/10/22.
//

import Foundation
import UIKit

extension UITextView {
    // Note: This will trigger a text rendering!
    func requiredHeight() -> CGFloat {
        let textWidth = self.frame.width -
            self.textContainerInset.left -
            self.textContainerInset.right -
            self.textContainer.lineFragmentPadding * 2.0 -
            self.contentInset.left -
            self.contentInset.right
        
        let maxSize = CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude)
        var calculatedSize = self.attributedText.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil).size
        calculatedSize.height += self.textContainerInset.top
        calculatedSize.height += self.textContainerInset.bottom
        
        return ceil(calculatedSize.height)
    }
}
