//
//  DeleteButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/12/22.
//

import Foundation
import UIKit
import SnapKit
import SMIconLabel

class DeleteButton: UIButton {
    required init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 50))
        
        layer.cornerRadius = 8
        layer.borderWidth = 1.5
        layer.borderColor = K.Color.greenQuint.cgColor
        
        backgroundColor = .white
        
        let iconLabel = SMIconLabel()
        iconLabel.icon = UIImage(named: "trashIconGreen")
        iconLabel.text = "Delete photo"
        iconLabel.textColor = K.Color.greenQuint
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
