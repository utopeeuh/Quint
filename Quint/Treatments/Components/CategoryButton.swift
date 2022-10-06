//
//  CategoryButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/10/22.
//

import UIKit

class CategoryButton: UIButton {
    private var categoryId: Int!
    
    required init(categoryId: Int, totalWidth: Int, index: Int) {
        super.init(frame: .zero)
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: totalWidth+K.Offset.sm*2*index, y: 10, width: 130, height: 40)
        
        self.categoryId = categoryId
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        
        backgroundColor = K.Color.whiteQuint
        setTitleColor(K.Color.greenQuint, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
        layer.cornerRadius = 10
    }
    
    func setText(_ title: String?) {
        setTitle(title, for: .normal)
        sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
