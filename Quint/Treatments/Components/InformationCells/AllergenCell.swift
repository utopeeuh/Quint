//
//  AllergenCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 12/10/22.
//

import Foundation
import UIKit
import SnapKit

class AllergenCell: InformationCell{
    required init(_ text: String) {
        super.init(text)
        setImage(UIImage(named:"AllergenIcon")!)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
