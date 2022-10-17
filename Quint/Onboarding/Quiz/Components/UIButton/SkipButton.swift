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
        backgroundColor = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        setTitleColor(UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1), for: .normal)
        
        layer.borderWidth = 1.5
        layer.borderColor = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1).cgColor
        
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor(red: 16/255, green: 24/255, blue: 40/255, alpha: 0.05).cgColor
        layer.shadowOpacity = 5.0
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

