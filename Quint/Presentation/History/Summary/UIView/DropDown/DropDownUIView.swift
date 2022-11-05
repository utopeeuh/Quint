//
//  DropDownUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 24/10/22.
//

import UIKit

class DropDownUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = K.Color.disableBgBtnQuint
        self.layer.cornerRadius = 10.0
        configureComponents()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    var lblTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .interMedium(size: 16)
        return label
    }()
    
    var dropDownIconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func configureComponents() {
        self.addSubview(lblTitle)
        self.addSubview(dropDownIconView)
    }
    
    override func configureLayout() {
        lblTitle.snp.makeConstraints { make in
            make.left.top.equalTo(self.safeAreaInsets).offset(5)
        }
        
        dropDownIconView.snp.makeConstraints { make in
            make.right.equalTo(self.safeAreaInsets).offset(-5)
            make.top.equalTo(self.safeAreaInsets).offset(12.5)
        }
    }

}
