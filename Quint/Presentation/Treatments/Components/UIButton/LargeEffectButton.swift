//
//  LargeCategoryCard.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import UIKit

class LargeEffectButton: LargeCategoryButton {
    
    var effect: EffectModel? {
        didSet{
            imgView.image = K.CategoryImage.ingredient[Int(truncating: effect?.id ?? 1)] as? UIImage
            title.text = effect?.title
            configureLayout()
        }
    }

    required init(id: Int) {
        super.init(id: id)
        
        width = 152
        height = 164
        frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
