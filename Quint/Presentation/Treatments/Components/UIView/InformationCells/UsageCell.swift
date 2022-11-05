//
//  UsageCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 12/10/22.
//

import Foundation
import UIKit
import SnapKit

class UsageCell: InformationCell{
    required init(_ text: String) {
        super.init(text)
        setImage(UIImage(named:"UsageIcon")!)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
