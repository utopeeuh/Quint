//
//  ProductCategoryLabel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/10/22.
//

import Foundation
import SnapKit
import UIKit
import SMIconLabel

class ProductCategoryLabel: UIView {
    
    private var typeLabel = UILabel()
    private var text: String!
    private var icon = UIImageView()
    
    public var height: CGFloat {
        return typeLabel.requiredHeight + 8
    }
    
    public var width: CGFloat {
        return typeLabel.frame.width + 24 + (icon.image?.size.width ?? -8) + 8
    }
    
    required init(text: String, icon: UIImage?){
        super.init(frame: .zero)
        self.text = text
        self.icon.image = icon
        configureUI()
    }
    
    override func configureComponents(){
        backgroundColor = UIColor(red: 214/255, green: 223/255, blue: 220/255, alpha: 1)
        layer.cornerRadius = 4
    
        typeLabel.font = .interSemiBold(size: 12)
        typeLabel.textColor = K.Color.greenQuint
        typeLabel.numberOfLines = 0
        typeLabel.lineBreakMode = .byWordWrapping
        typeLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
        
        typeLabel.text = self.text
        typeLabel.sizeToFit()
    }
    
    override func configureLayout(){
        addSubview(typeLabel)
        addSubview(icon)

        typeLabel.snp.makeConstraints { make in
            if icon.image == nil {
                make.center.equalToSuperview()
            }
            else {
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-12)
            }
        }
        
        icon.snp.makeConstraints { make in
            make.centerY.equalTo(typeLabel)
            make.size.equalTo(10.67)
            make.left.equalToSuperview().offset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
