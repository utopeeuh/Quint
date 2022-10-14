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
        
    }

    func setText(_ title: String?) {
        setTitle(title, for: .normal)
        sizeToFit()
    }
    
    func buttonDisabled(){
//        self.layer.sublayers?.removeFirst()
//        applyGradient(colours: [.white, .white], locations: [1.0, 0.0])
//        setTitleColor(K.Color.greenQuint, for: .normal)
//        titleLabel?.font = .interMedium(size: 13)
//        sizeToFit()
        
        titleLabel?.font = .clashGroteskMedium(size: 18)
        
        layer.cornerRadius = 8
        backgroundColor = K.Color.disableBgBtnQuint
        setTitleColor(K.Color.disableTextBtnQuint, for: .normal)
        
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = K.Color.shadowQuint.cgColor
        layer.shadowOpacity = 5.0
    }
    
    func buttonEnabled(){
//        layer.sublayers?.removeFirst()
//        applyGradient(colours: [K.Color.greenQuint, K.Color.greenLightQuint], locations: [1.0, 0.0])
//        setTitleColor(K.Color.whiteQuint, for: .normal)
//        titleLabel?.font = .interSemiBold(size: 13)
//        sizeToFit()
        
        titleLabel?.font = .clashGroteskMedium(size: 18)
        
        layer.cornerRadius = 8
        backgroundColor = K.Color.greenButtonQuint
        setTitleColor(K.Color.whiteQuint, for: .normal)
        
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = K.Color.shadowQuint.cgColor
        layer.shadowOpacity = 5.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

