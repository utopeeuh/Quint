//
//  ActivityView.swift
//  Quint
//
//  Created by Vendly on 25/10/22.
//

import UIKit
import SnapKit

class NoActivityView: UIView {
    
    private var activityImage = UIImageView()
    private var titleLabel = UILabel()
    private var captionLabel = UILabel()
    private var logButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureComponents() {

        activityImage.image = UIImage(named: "activity_icon")
        
        titleLabel.text = "No activity today"
        titleLabel.textColor = K.Color.blackQuint
        titleLabel.font = .clashGroteskMedium(size: 24)
        
        captionLabel.text = "You have to fill today skin log first"
        captionLabel.textColor = K.Color.blackQuint
        captionLabel.font = .interRegular(size: 16)
        
        logButton.setTitle("Fill in log", for: .normal)
        logButton.setTitleColor(K.Color.whiteQuint, for: .normal)
        logButton.titleLabel?.font = .clashGroteskMedium(size: 18)

        logButton.frame = CGRect(x: 0, y: 0, width: 151, height: 50)
        logButton.applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 8)
        
    }

    override func configureLayout() {

        multipleSubviews(view: activityImage,
                               titleLabel,
                               captionLabel,
                               logButton)
        
        activityImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.width.equalToSuperview().offset(-226)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(activityImage.snp.bottom).offset(12)
        }
        
        captionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        logButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(captionLabel.snp.bottom).offset(32)
            make.width.equalToSuperview().offset(-239)
            make.height.equalTo(50)
        }
        
    }
    
}
