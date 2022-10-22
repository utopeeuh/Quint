//
//  NextButton.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit

class NextButton: UIButton {
    
    required init() {
        super.init(frame: .zero)
        
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 50)
//        applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0, 1])
        
        backgroundColor = K.Color.disableBgBtnQuint
        setTitleColor(K.Color.disableTextBtnQuint, for: .normal)
        titleLabel?.font = .clashGroteskMedium(size: 18)
        layer.cornerRadius = 8
        
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = K.Color.shadowQuint.cgColor
        layer.shadowOpacity = 5.0
    }

    func setText(_ title: String?) {
        setTitle(title, for: .normal)
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

