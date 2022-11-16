//
//  SmallCategoryButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import Foundation
import UIKit

class SmallCategoryButton: CategoryButton{
    
    required init(id: Int) {
        super.init(id: .zero)
        
        self.id = id
        width = 130
        height = 36
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        
        applyGradient(colours: [K.Color.greenQuint, K.Color.greenLightQuint], locations: [1.0, 0.0], radius: 10)
//        backgroundColor = K.Color.whiteQuint
        setTitleColor(K.Color.greenQuint, for: .normal)
        titleLabel?.font = .interMedium(size: 13)
        layer.cornerRadius = 10
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deselect(){
        self.layer.sublayers?.removeFirst()
        applyGradient(colours: [.white, .white], locations: [1.0, 0.0], radius: 10)
        setTitleColor(K.Color.greenQuint, for: .normal)
        titleLabel?.font = .interMedium(size: 13)
        sizeToFit()
        
        self.layer.sublayers?.removeFirst()
        applyGradient(colours: [.white, .white], locations: [1.0, 0.0], radius: 10)
        setTitleColor(K.Color.greenQuint, for: .normal)
        titleLabel?.font = .interMedium(size: 13)
        sizeToFit()
    }
    
    func select(){
        layer.sublayers?.removeFirst()
        applyGradient(colours: [K.Color.greenQuint, K.Color.greenLightQuint], locations: [1.0, 0.0], radius: 10)
        setTitleColor(K.Color.whiteQuint, for: .normal)
        titleLabel?.font = .interSemiBold(size: 13)
        sizeToFit()
    }
}
