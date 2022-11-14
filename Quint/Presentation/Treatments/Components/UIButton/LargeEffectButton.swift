//
//  LargeCategoryCard.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import UIKit

class LargeEffectButton: LargeCategoryButton {

    required init(id: Int) {
        super.init(id: id)
        imgView.image = K.CategoryImage.ingredient[id] as? UIImage
        title.text = K.Category.ingredient[id]
        width = 152
        height = 164
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
