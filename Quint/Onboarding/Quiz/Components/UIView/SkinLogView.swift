//
//  SkinLogView.swift
//  Quint
//
//  Created by Vendly on 15/10/22.
//

import UIKit

class SkinLogView: UIView {
    
    private let skinLogLabel = UILabel()
    private let skinLogCaptionLabel = UILabel()
    private let skinLogLogo = UIImageView()
    private let takePhotoButton = OnboardingButton()
    private let skipButton = SkipButton()
    
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
        
        skinLogLabel.numberOfLines = 2
        skinLogLabel.textColor = K.Color.blackQuint
        skinLogLabel.text = "Let's take your first skin log selfie"
        skinLogLabel.font = .clashGroteskMedium(size: 30)
        skinLogLabel.textAlignment = .center
        
        skinLogCaptionLabel.numberOfLines = 2
        skinLogCaptionLabel.textColor = K.Color.blackQuint
        skinLogCaptionLabel.text = "This skin log will mark the first day of your skin condition journey."
        skinLogCaptionLabel.font = .interRegular(size: 16)
        skinLogCaptionLabel.textAlignment = .center
        
        skinLogLogo.image = UIImage(named: "face_logo")
        
        takePhotoButton.setText("Take photo")
        
    }
    
    func configureLayout() {
        
        addSubview(skinLogLabel)
        addSubview(skinLogCaptionLabel)
        addSubview(skinLogLogo)
        addSubview(takePhotoButton)
        addSubview(skipButton)
        
        skinLogLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(147)
            make.width.equalToSuperview().offset(-40)
        }
        
        skinLogCaptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinLogLabel.snp.bottom).offset(14)
            make.width.equalToSuperview().offset(-40)
        }
        
        skinLogLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(skinLogCaptionLabel.snp.bottom).offset(56)
        }
        
        takePhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-124)
            make.width.equalToSuperview().offset(-40)
        }
        
        skipButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-62)
            make.width.equalToSuperview().offset(-40)
        }

        
    }
    
}
