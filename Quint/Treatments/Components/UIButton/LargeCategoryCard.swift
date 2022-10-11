//
//  LargeCategoryCard.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import UIKit

class LargeCategoryCard: CategoryButton {

    var categoryCard: UIView!
    var imgView: UIImageView!
    var title = UILabel()
    var cardStack = UIStackView()
    
    required init(categoryId: Int) {
        super.init(categoryId: .zero)
        
        self.categoryId = categoryId
        width = 152
        height = 164
        
        frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        layer.cornerRadius = 10
        
//        categoryCard = UIView(frame: self.frame)
//        categoryCard.isUserInteractionEnabled = false
        
        imgView = UIImageView(image: K.CategoryImage.ingredient[self.categoryId] as? UIImage)
        title.textColor = K.Color.greenQuint
        title.font = .interMedium(size: 16)
        title.frame = CGRect(x: 0, y: 0, width: 104, height: 0)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        title.textAlignment = .center
        
        cardStack.axis = .vertical
        cardStack.alignment = .top
        cardStack.spacing = 16
        cardStack.addArrangedSubview(imgView)
        cardStack.addArrangedSubview(title)
        cardStack.translatesAutoresizingMaskIntoConstraints = false
        cardStack.backgroundColor = .white
        cardStack.alignment = .center
        
        backgroundColor = .white
    }
    
    func configureLayout(){
        
        self.addSubview(cardStack)
        
        title.snp.makeConstraints { make in
            make.height.equalTo(title.requiredHeight)
        }
        
        cardStack.snp.makeConstraints { make in
            make.left.equalTo(self).offset(24)
            make.right.equalTo(self).offset(-24)
            make.centerY.equalTo(self)
            make.height.equalTo(52+title.requiredHeight+16)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setText(_ title: String?) {
        self.title.text = title
        configureLayout()
    }


}
