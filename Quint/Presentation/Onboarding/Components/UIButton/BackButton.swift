//
//  BackButton.swift
//  Quint
//
//  Created by Vendly on 13/10/22.
//

import UIKit

class BackButton: UIButton {
    
    required init() {
        super.init(frame: .zero)
        setImage(UIImage(named: "arrow_back"), for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
