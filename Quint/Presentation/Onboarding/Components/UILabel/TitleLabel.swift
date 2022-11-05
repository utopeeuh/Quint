//
//  TitleLabel.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 88, height: 0)
        font = .interSemiBold(size: 12)
        textColor = K.Color.whiteQuint
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
