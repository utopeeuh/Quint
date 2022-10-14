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
        setTitleColor(UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1), for: .normal)
        
        layer.cornerRadius = 8
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        setImage(UIImage(named: "apple_logo"), for: .normal)
        imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 25)
        
        layer.borderWidth = 1.5
        backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        layer.borderColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1).cgColor
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
