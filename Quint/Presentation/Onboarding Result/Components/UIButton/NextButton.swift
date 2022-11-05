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
        
        isEnabled = false
        backgroundColor = K.Color.disableBgBtnQuint
        setTitleColor(K.Color.greyQuint, for: .normal)
        titleLabel?.font = .clashGroteskMedium(size: 18)
        layer.cornerRadius = 8
        
    }

    func setText(_ title: String?) {
        setTitle(title, for: .normal)
        sizeToFit()
    }
    
    func setEnabled(){
        isEnabled = true
        applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0, 1], radius: 8)
        setTitleColor(K.Color.whiteQuint, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

