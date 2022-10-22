//
//  CustomCellView.swift
//  Quint
//
//  Created by Vendly on 20/10/22.
//

import UIKit
import SnapKit

class CustomCellView: UIView {
    
    public var containerBox = UIView()
    public var numberLabel = UILabel()
    public var stepsLabel = UILabel()
    public var tagView = UIView()
    public var tagLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        containerBox.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-80, height: 56)
        containerBox.backgroundColor = K.Color.whiteQuint
        containerBox.layer.cornerRadius = 8
        containerBox.layer.shadowColor = K.Color.greyQuint.cgColor
        containerBox.layer.shadowOpacity = 0.5
        containerBox.layer.shadowOffset = CGSize(width: 0.2, height: 0.3)
        
        numberLabel.text = "1"
        numberLabel.layer.cornerRadius = 12
        numberLabel.layer.backgroundColor = K.Color.greyWhiteQuint.cgColor
        numberLabel.textColor = K.Color.blackQuint
        numberLabel.textAlignment = .center
        numberLabel.font = .interMedium(size: 14)

        stepsLabel.text = "Cleanser"
        stepsLabel.textColor = K.Color.blackQuint
        stepsLabel.font = .interMedium(size: 16)
        
        tagLabel.textAlignment = .center
        tagLabel.font = .interSemiBold(size: 12)
        
    }
    
    func configureLayout() {

        multipleSubviews(view: containerBox,
                               numberLabel,
                               stepsLabel,
                               tagView,
                               tagLabel)
        
        containerBox.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(56)
            make.width.equalToSuperview()
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(containerBox).offset(16)
            make.width.height.equalTo(24)
        }
        
        stepsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerBox)
            make.leading.equalTo(numberLabel.snp.trailing).offset(10)
        }

        tagView.snp.makeConstraints { make in
            make.centerY.equalTo(containerBox)
            make.leading.equalTo(stepsLabel.snp.trailing).offset(10)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(tagView.snp.top).offset(3)
            make.bottom.equalTo(tagView.snp.bottom).offset(-3)
            make.leading.equalTo(tagView.snp.leading).offset(8)
            make.trailing.equalTo(tagView.snp.trailing).offset(-8)
        }
        
    }
    
    func setAsNight() {
        
        containerBox.applyGradient(colours: [K.Color.blueLightQuint, K.Color.blueQuint], locations: [0, 1])
        
        numberLabel.layer.backgroundColor = K.Color.blueQuint.cgColor
        numberLabel.textColor = K.Color.whiteQuint

        stepsLabel.textColor = K.Color.whiteQuint
        
        tagView.layer.cornerRadius = 10
        tagView.layer.backgroundColor = UIColor(red: 168/255, green: 178/255, blue: 209/255, alpha: 1).cgColor
        tagLabel.text = "Night"
        tagLabel.textColor = K.Color.blueQuint
        
    }
    
    func setAsMorning() {
        
        containerBox.applyGradient(colours: [K.Color.orangeLightQuint, K.Color.orangeQuint], locations: [0, 1])
        
        numberLabel.layer.backgroundColor = K.Color.orangeQuint.cgColor
        numberLabel.textColor = K.Color.whiteQuint

        stepsLabel.textColor = K.Color.whiteQuint
        
        tagView.layer.cornerRadius = 10
        tagView.layer.backgroundColor = UIColor(red: 255/255, green: 230/255, blue: 212/255, alpha: 1).cgColor
        tagLabel.text = "Morning"
        tagLabel.textColor = K.Color.orangeQuint
        
    }
    
}
