//
//  ResultLabel.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit

class ResultLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 0)
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        font = .clashGroteskMedium(size: 24)
        textColor = K.Color.whiteQuint
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
