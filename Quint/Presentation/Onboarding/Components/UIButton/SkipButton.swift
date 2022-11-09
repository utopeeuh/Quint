//
//  SkipButton.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit

class SkipButton: UIButton {
    
    required init() {
        super.init(frame: .zero)
        
        setTitle("Skip", for: .normal)
        titleLabel?.font = .clashGroteskMedium(size: 18)
        
        layer.cornerRadius = 8
        backgroundColor = K.Color.whiteQuint
        setTitleColor(K.Color.greenQuint, for: .normal)
        
        layer.borderWidth = 1.5
        layer.borderColor = K.Color.greenQuint.cgColor
        
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = K.Color.shadowQuint.cgColor
        layer.shadowOpacity = 5.0
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

