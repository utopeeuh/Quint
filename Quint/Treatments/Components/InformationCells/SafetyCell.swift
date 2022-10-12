//
//  SafetyCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 12/10/22.
//

import Foundation
import UIKit
import SnapKit

class SafetyCell: InformationCell{
    required init() {
        let text = "Immediately stop using in case of skin abnormalities after use. Always recap after use. Use as quickly as possible after opening."
        super.init(text)
        setImage(UIImage(named:"SafetyIcon")!)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    required init(_ text: String) {
        fatalError("init(_:) has not been implemented")
    }
}
