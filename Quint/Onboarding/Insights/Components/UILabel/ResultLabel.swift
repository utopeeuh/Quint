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
        font = .clashGroteskMedium(size: 24)
        textColor = K.Color.whiteQuint
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
