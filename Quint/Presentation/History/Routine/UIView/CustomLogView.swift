//
//  CustomLogView.swift
//  Quint
//
//  Created by Vendly on 25/10/22.
//

import UIKit
import SnapKit

class CustomLogView: UIView {
    
    private var logIcon = UIImageView()
    private var titleLabel = UILabel()
    private var descLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureComponents() {
        
        backgroundColor = K.Color.whiteQuint
        layer.cornerRadius = 8
        
        titleLabel.text = ""
        titleLabel.font = .interRegular(size: 13)
        titleLabel.textColor = K.Color.greyQuint
        
        descLabel.text = ""
        descLabel.font = .interSemiBold(size: 18)
        descLabel.textColor = K.Color.blackQuint
        descLabel.numberOfLines = 0

    }
    
    override func configureLayout() {

        multipleSubviews(view: logIcon,
                               titleLabel,
                               descLabel)
        
        logIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalTo(logIcon.snp.trailing).offset(12)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
        }
        
    }
    
    func setBackground(_ bgColor: UIColor?) {
        backgroundColor = bgColor
    }
    
    func setImage(_ image: UIImage?) {
        logIcon.image = image
        sizeToFit()
    }
    
    func setTitle(_ title: String?, _ color: UIColor?) {
        titleLabel.text = title
        titleLabel.textColor = color
        sizeToFit()
    }
    
    func setDesc(_ desc: String?, _ color: UIColor?) {
        descLabel.text = desc
        descLabel.textColor = color
        sizeToFit()
    }
    
}
