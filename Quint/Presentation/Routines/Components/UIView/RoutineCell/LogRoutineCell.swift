//
//  LogRoutineCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/11/22.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 16.0, *)
class LogRoutineCell: RoutineCell{
    required init() {
        super.init()
        
        leftBtn.setImage(UIImage(named: "LockClosed"), for: .normal)
        leftBtn.isEnabled = true
        imageRoutine.image = UIImage(named: "iconLog")
        titleRoutine.text = "Daily skin condition log"
        btnId = 3
        currPosition = 3
        name = "log"
        isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func pressed() {
        self.alpha = 0.6
        self.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.isUserInteractionEnabled = false
        
        leftBtn.setImage(UIImage(named: "CheckmarkFill"), for: .normal)
        
        titleRoutine.attributedText = NSAttributedString(
            string: "Daily skin condition log",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        rearrangeStack()
    }
}
