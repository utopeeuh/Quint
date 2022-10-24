//
//  ProductCategoryLabel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 13/10/22.
//

import Foundation
import SnapKit
import UIKit

class ProductCategoryLabel: UIView {
    
    private var typeLabel = UILabel()
    private var typeText: String!
    
    public var height: CGFloat {
        return typeLabel.requiredHeight + 8
    }
    
    public var width: CGFloat {
        return typeLabel.frame.width + 24
    }
    
    required init(_ text: String){
        super.init(frame: .zero)
        typeText = text.uppercased()
        configureUI()
    }
    
    override func configureComponents(){
        backgroundColor = K.Color.greenLightQuint
        layer.cornerRadius = 4
    
        typeLabel.font = .interSemiBold(size: 12)
        typeLabel.textColor = K.Color.whiteQuint
        typeLabel.numberOfLines = 0
        typeLabel.lineBreakMode = .byWordWrapping
        typeLabel.frame = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width-80)/2, height: 0)
        
        typeLabel.text = typeText
        typeLabel.sizeToFit()
    }
    
    override func configureLayout(){
        addSubview(typeLabel)

        typeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        print(typeLabel.frame.width)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
