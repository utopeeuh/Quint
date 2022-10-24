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
        font = .interSemiBold(size: 12)
        textColor = K.Color.whiteQuint
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
