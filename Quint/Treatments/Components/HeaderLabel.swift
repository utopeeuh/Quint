//
//  HeaderLabel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/10/22.
//

import Foundation
import UIKit

class HeaderLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        text = "Recommended products"
        font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
