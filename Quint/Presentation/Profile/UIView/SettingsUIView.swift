//
//  SettingsUIView.swift
//  Quint
//
//  Created by Stefanus Hermawan Sebastian on 31/10/22.
//

import UIKit

class SettingsUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 8.0
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var iconImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var namelabel: UILabel = {
        let label = UILabel()
        label.font = .interMedium(size: 16)
        label.textColor = .black
        return label
    }()
    
    var chevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = K.Color.greyQuint
        return imageView
    }()
    
    override func configureComponents() {
        self.addSubview(iconImage)
        self.addSubview(namelabel)
        self.addSubview(chevronImage)
    }
    
    override func configureLayout() {
        
        iconImage.snp.makeConstraints { make in
            make.left.top.equalTo(self.safeAreaInsets).offset(9)
        }
        
        namelabel.snp.makeConstraints { make in
            make.left.equalTo(iconImage.snp.right).offset(15)
            make.top.equalTo(self.safeAreaInsets).offset(14.5)
        }
        
        chevronImage.snp.makeConstraints { make in
            make.right.equalTo(self.safeAreaInsets).offset(-9)
            make.top.equalTo(15)
        }
    }

}
