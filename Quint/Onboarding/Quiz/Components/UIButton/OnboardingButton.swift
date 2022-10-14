//
//  OnboardingButton.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit

class OnboardingButton: UIButton {
    
    required init() {
        super.init(frame: .zero)
        
//        setTitle("Get started", for: .normal)
        titleLabel?.font = .clashGroteskMedium(size: 18)
//        applyGradient(colours: [K.Color.greenLightQuint, K.Color.greenQuint], locations: [0.0, 1.0])
        setTitleColor(K.Color.whiteQuint, for: .normal)
        layer.cornerRadius = 8
        backgroundColor = K.Color.greenQuint
//        sizeToFit()
    }

    func setText(_ title: String?) {
        setTitle(title, for: .normal)
        sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
