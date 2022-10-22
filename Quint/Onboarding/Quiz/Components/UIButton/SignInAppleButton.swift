//
//  SignInAppleButton.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit

class SignInAppleButton: UIButton {
    
    required init() {
        super.init(frame: .zero)
        
        setTitle("Continue with Apple", for: .normal)
        titleLabel?.font = .clashGroteskMedium(size: 18)
        setTitleColor(K.Color.greenQuint, for: .normal)
        
        layer.cornerRadius = 8
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        setImage(UIImage(named: "apple_logo"), for: .normal)
        imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 25)
        
        layer.borderWidth = 1.5
        backgroundColor = K.Color.whiteQuint
        layer.borderColor = K.Color.greenQuint.cgColor
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
