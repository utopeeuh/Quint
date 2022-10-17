//
//  DescriptionLabel.swift
//  Quint
//
//  Created by Vendly on 17/10/22.
//

import UIKit

class DescriptionLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .interRegular(size: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
