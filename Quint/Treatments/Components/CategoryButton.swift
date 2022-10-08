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
        setImage(UIImage(named: "imageCategoryName"), for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
