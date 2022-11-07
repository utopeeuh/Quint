//
//  NightRoutineCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/11/22.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 16.0, *)
class NightRoutineCell: RoutineCell{
    required init() {
        super.init()
        
        leftBtn.setImage(UIImage(named: "Checkmark"), for: .normal)
        imageRoutine.image = UIImage(named: "iconNight")
        titleRoutine.text = "Night routine"
        btnId = 2
        currPosition = 2
        name = "night"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func pressed() {
        self.alpha = 0.6
        self.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.isUserInteractionEnabled = false
        self.isChecked = true
        
        leftBtn.setImage(UIImage(named: "CheckmarkFill"), for: .normal)
        imageRoutine.image = UIImage(named: "iconNightDisabled")
        titleRoutine.attributedText = NSAttributedString(
            string: "Night routine",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        
        LogRepository.shared.setRoutineAsDone(time: .night)
        
        // Hide reminder
        delegate?.hideRoutineReminder()
        
        rearrangeStack()
    }
}

