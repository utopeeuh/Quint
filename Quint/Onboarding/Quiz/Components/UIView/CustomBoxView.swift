//
//  CustomBoxView.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit
import SnapKit

class CustomBoxView: UIView {
    
    public let containerBox = UIView()
    public let contentBox = UIView()
    public var labelContainer = UILabel()
    public var labelContent = UILabel()
    private var leftBorder = UIView()
    
    required init(title: String, desc: String) {
        super.init(frame: .zero)
        
        labelContainer.text = title
        labelContent.text = desc
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        configureComponents()
        configureLayout()
    }
    
    func configureComponents() {
        
        leftBorder.backgroundColor = K.Color.greenQuint
        
        containerBox.backgroundColor = K.Color.whiteQuint
        containerBox.layer.cornerRadius = 8
        containerBox.layer.borderWidth = 1.5
        containerBox.layer.borderColor = K.Color.greenQuint.cgColor
        
        labelContainer.textColor = K.Color.greenQuint
        labelContainer.font = .interSemiBold(size: 16)
        
        labelContent.numberOfLines = 0
        labelContent.textColor = K.Color.blackQuint
        labelContent.font = .interRegular(size: 14)
        labelContent.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-51.5, height: 0)
        labelContent.lineBreakMode = .byWordWrapping
        labelContent.sizeToFit()
        
        contentBox.frame = CGRect(x: 0, y: 0, width: 0, height: labelContent.requiredHeight)
        contentBox.backgroundColor = K.Color.bgQuint
        
    }
    
    func configureLayout() {
        
        addSubview(containerBox)
        addSubview(labelContainer)
        addSubview(contentBox)
        addSubview(labelContent)
        addSubview(leftBorder)
        
        containerBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(52)
            make.width.equalToSuperview().offset(-40)
        }
        
        labelContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerBox)
            make.height.equalTo(containerBox)
            make.width.equalToSuperview().offset(-72)
        }
        
        contentBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerBox.snp.bottom).offset(14)
            make.height.equalTo(labelContent.requiredHeight)
            make.width.equalTo(containerBox)
        }
        
        labelContent.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31.5)
            make.top.equalTo(contentBox)
            make.height.equalTo(labelContent.requiredHeight)
            make.width.equalToSuperview().offset(-51.5)
        }
        
        leftBorder.snp.makeConstraints { make in
            make.top.equalTo(containerBox.snp.bottom).offset(14)
            make.left.equalTo(containerBox)
            make.width.equalTo(1.5)
            make.height.equalTo(labelContent)
        }
        
    }
    
}
