//
//  LargeCategoryButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 14/11/22.
//

import UIKit

class LargeCategoryButton: CategoryButton {

    var categoryCard: UIView!
    var imgView = UIImageView()
    var title = UILabel()
    var cardStack = UIStackView()
    
    required init(id: Int) {
        super.init(id: .zero)
        
        self.id = id
        
        layer.cornerRadius = 10
                
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
        cardStack.isUserInteractionEnabled = false
        cardStack.backgroundColor = .white
        cardStack.alignment = .center
        
        backgroundColor = .white
    }
    
    override func configureLayout(){
        
        self.addSubview(cardStack)
        
        title.snp.makeConstraints { make in
            make.height.equalTo(title.requiredHeight)
        }
        
        cardStack.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.centerY.centerX.equalToSuperview()
            make.height.equalTo(52+title.requiredHeight+16)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
