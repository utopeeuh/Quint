//
//  SmallCategoryButtonGuide.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 08/10/22.
//

import Foundation
import UIKit

class SmallCategoryButtonGuide: CategoryButton{
    
    required init(categoryId: Int) {
        super.init(categoryId: .zero)
        
        self.categoryId = categoryId
        width = 120
        height = 144
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        backgroundColor = K.Color.whiteQuint
        setTitleColor(K.Color.greenQuint, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        layer.cornerRadius = 10
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func deselect(){
        backgroundColor = K.Color.whiteQuint
        setTitleColor(K.Color.greenQuint, for: .normal)
    }
    
    func selectGuide(){
        backgroundColor = .systemGray6
        setTitleColor(K.Color.greenQuint, for: .normal)
    }
    
    func select(){
        backgroundColor = K.Color.greenQuint
        setTitleColor(K.Color.whiteQuint, for: .normal)
    }
}
