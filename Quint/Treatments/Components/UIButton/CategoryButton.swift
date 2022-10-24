//
//  CategoryButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/10/22.
//

import UIKit

class CategoryButton: UIButton {
    var categoryId: Int!
    var width: Int!
    var height: Int!
    var heightProductGuide: Int!
    
    required init(categoryId: Int) {
        super.init(frame: .zero)
        self.categoryId = categoryId
    }
    
    func setText(_ title: String?) {
        setTitle(title, for: .normal)
        sizeToFit()
    }
    
    func setImageCategory(_ imageCategoryName: String?) {
        setImage(UIImage(named: imageCategoryName ?? ""), for: .normal)
        sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UIButton {
    
    func centerVertically(padding: CGFloat = 5.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
            return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
    
}
