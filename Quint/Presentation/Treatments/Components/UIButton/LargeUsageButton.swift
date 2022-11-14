//
//  LargeUsageButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 14/11/22.
//

import UIKit

class LargeUsageButton: LargeCategoryButton {

    required init(id: Int) {
        super.init(id: id)
        imgView.image = K.CategoryImage.product[id] as? UIImage
        title.text = K.Category.product[id]
        height = 144
        width = 120
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        configureLayout()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
