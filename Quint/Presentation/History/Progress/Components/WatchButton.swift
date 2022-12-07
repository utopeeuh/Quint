//
//  WatchButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/12/22.
//

import Foundation
import UIKit
import SnapKit
import SMIconLabel

class WatchButton: UIButton {
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 50))
        
        layer.cornerRadius = 8
        applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0,1], radius: 8)
        
        let iconLabel = SMIconLabel()
        iconLabel.icon = UIImage(named: "playArrow")
        iconLabel.text = "Watch progress"
        iconLabel.textColor = .white
        iconLabel.font = .clashGroteskMedium(size: 18)
        iconLabel.iconPosition = (.left, .center)
        iconLabel.iconPadding = 6
        iconLabel.textAlignment = .center
        iconLabel.isUserInteractionEnabled = false
        
        addSubview(iconLabel)
        iconLabel.snp.makeConstraints { make in
            make.center.size.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
