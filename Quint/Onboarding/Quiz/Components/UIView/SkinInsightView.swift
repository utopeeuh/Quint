//
//  SkinInsightView.swift
//  Quint
//
//  Created by Vendly on 15/10/22.
//

import UIKit
import SnapKit

class SkinInsightView: OnboardingParentView {
    
    private let insightLabel = UILabel()
    private let insightCaptionLabel = UILabel()
    private let insightsLogo = UIImageView()
    public let insightsButton = OnboardingButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureComponents() {
        
        insightLabel.numberOfLines = 2
        insightLabel.textColor = K.Color.blackQuint
        insightLabel.text = "We got your skin insights & recommendation ready!"
        insightLabel.font = .clashGroteskMedium(size: 30)
        insightLabel.textAlignment = .center
        
        insightCaptionLabel.numberOfLines = 3
        insightCaptionLabel.textColor = K.Color.blackQuint
        insightCaptionLabel.text = "Quint has prepared you a brief skin analysis result and personalized recommendation for your current skin condition"
        insightCaptionLabel.font = .interRegular(size: 16)
        insightCaptionLabel.textAlignment = .center
        
        insightsLogo.image = UIImage(named: "receipt_logo")
        
        insightsButton.setText("See insights")
        
    }
    
    override func configureLayout() {
        
        addSubview(insightLabel)
        addSubview(insightCaptionLabel)
        addSubview(insightsLogo)
        addSubview(insightsButton)
        
        insightLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
        }
        
        insightCaptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(insightLabel.snp.bottom).offset(14)
            make.width.equalToSuperview().offset(-40)
        }
        
        insightsLogo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(insightCaptionLabel.snp.bottom).offset(56)
        }
       
        insightsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalToSuperview().offset(-40)
        }
        
    }
    
}
