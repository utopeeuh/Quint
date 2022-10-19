//
//  SkinNotifView.swift
//  Quint
//
//  Created by Vendly on 15/10/22.
//

import UIKit
import SnapKit

class SkinNotifView: OnboardingParentView {
    
    private let notifLabel = UILabel()
    private let notifCaptionLabel = UILabel()
    private let notifLogo = UIImageView()
    public let notifButton = OnboardingButton()
    
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
        
        notifLabel.numberOfLines = 2
        notifLabel.textColor = K.Color.blackQuint
        notifLabel.text = "We will help you stay on track to gain consistency"
        notifLabel.font = .clashGroteskMedium(size: 30)
        notifLabel.textAlignment = .center
        
        notifCaptionLabel.numberOfLines = 2
        notifCaptionLabel.textColor = K.Color.blackQuint
        notifCaptionLabel.text = "Allow Quint to send you reminders through notifications"
        notifCaptionLabel.font = .interRegular(size: 16)
        notifCaptionLabel.textAlignment = .center
        
        notifLogo.image = UIImage(named: "notif_logo")
        
        notifButton.setText("Allow notifications")
        notifButton.addTarget(self, action: #selector(nextOnClick), for: .touchUpInside)
        
    }
    
    func configureLayout() {
        
        addSubview(notifLabel)
        addSubview(notifCaptionLabel)
        addSubview(notifLogo)
        addSubview(notifButton)
        
        notifLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        
        notifCaptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(notifLabel.snp.bottom).offset(14)
            make.width.equalToSuperview().offset(-40)
        }
        
        notifLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(notifCaptionLabel.snp.bottom).offset(56)
        }
        
        notifButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalToSuperview().offset(-40)
        }
        
    }
    
}
