//
//  QuickFactCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 18/10/22.
//

import Foundation
import SnapKit
import UIKit

class QuickFactCell: UIView{
    
    private var numberLbl = UILabel()
    private var numberArea = UIView()
    private var title: String!
    private var desc: String!
    private var number: Int!
    private var textLbl = UILabel()
    
    required init(title: String, desc: String, number: Int) {
        super.init(frame: .zero)
        self.title = title
        self.desc = desc
        self.number = number
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func configureComponents(){
        backgroundColor = K.Color.whiteQuint
        layer.cornerRadius = 8
        
        numberArea.backgroundColor = K.Color.bgQuint
        numberArea.layer.cornerRadius = 12
        
        numberLbl.font = .interMedium(size: 14)
        numberLbl.text = String(describing: number!)
        
        textLbl.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 106, height: 0)
        textLbl.attributedText =
            NSMutableAttributedString()
            .bold("\(title!): ")
            .normal(desc)
        textLbl.numberOfLines = 0
        textLbl.lineBreakMode = .byWordWrapping
        textLbl.sizeToFit()
    }
    
    override func configureLayout(){
        
        addSubview(numberArea)
        addSubview(numberLbl)
        addSubview(textLbl)
        
        self.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(32+textLbl.requiredHeight)
        }
        
        numberArea.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(16)
            make.height.width.equalTo(24)
        }
        
        numberLbl.snp.makeConstraints { make in
            make.center.equalTo(numberArea)
            make.height.equalTo(numberLbl.requiredHeight)
        }
        
        textLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(numberArea.snp.right).offset(10)
            make.height.equalTo(textLbl.requiredHeight)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func getHeight()->CGFloat{
        return textLbl.requiredHeight+32
    }
}
