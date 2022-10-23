//
//  SmallCategoryButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import Foundation
import UIKit

class SmallCategoryButton: CategoryButton{
    
    required init(categoryId: Int) {
        super.init(categoryId: .zero)
        
        self.categoryId = categoryId
        width = 130
        height = 40
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        backgroundColor = K.Color.whiteQuint
        setTitleColor(K.Color.greenQuint, for: .normal)
        titleLabel?.font = .interMedium(size: 13)
        layer.cornerRadius = 10
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deselect(){
        backgroundColor = K.Color.whiteQuint
        setTitleColor(K.Color.greenQuint, for: .normal)
    }
    
    func select(){
//        self.frame = CGRect(x: 0, y: 0, width: 91, height: 36)
//        self.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 8)
//        titleLabel?.font = .interSemiBold(size: 13)
        backgroundColor = K.Color.greenQuint
        setTitleColor(K.Color.whiteQuint, for: .normal)
    }
}
