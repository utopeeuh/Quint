//
//  IngredientButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import UIKit

class IngredientButton: CategoryButton {

    required init(categoryId: Int) {
        super.init(categoryId: .zero)
        self.categoryId = categoryId
        width = 158
        height = 88
        frame = CGRect(x: 0, y: 0, width: 158, height: 88)
//        contentEdgeInsets = UIEdgeInsets(top: 18, left: 24, bottom: 18, right: 24)
        layer.cornerRadius = 10
        backgroundColor = K.Color.whiteQuint
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        setTitleColor(.black, for: .normal)
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = .center
    }
    
    override func setText(_ title: String?) {
        setTitle(title, for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
