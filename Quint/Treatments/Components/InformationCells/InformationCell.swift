//
//  InformationCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 12/10/22.
//

import Foundation
import UIKit
import SnapKit

class InformationCell: UIView{
    
    var iconImageView = UIImageView()
    var descLabel = UILabel()
    
    required init(_ text: String) {
        super.init(frame: .zero)
        setText(text)
        configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func configureComponents(){
        backgroundColor = K.Color.whiteQuint
        layer.cornerRadius = 8
    
        //inter medium 16
        descLabel.font = .interMedium(size: 16)
        descLabel.numberOfLines = 0
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40-32-10-32, height: 0)
    }
    
    func setText(_ text: String){
        descLabel.text = text
        descLabel.sizeToFit()
    }
    
    func setImage(_ image: UIImage){
        iconImageView.image = image
    }
    
    func configureLayout(){
        addSubview(iconImageView)
        addSubview(descLabel)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(descLabel.requiredHeight + 36)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(32)
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-14)
        }
    }
}
