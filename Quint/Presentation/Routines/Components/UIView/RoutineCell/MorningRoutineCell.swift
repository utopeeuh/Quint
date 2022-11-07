//
//  MorningRoutineCell.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 07/11/22.
//

import Foundation
import UIKit
import SnapKit

@available(iOS 16.0, *)
class MorningRoutineCell: RoutineCell {
    
    required init() {
        super.init()
        
        leftBtn.setImage(UIImage(named: "Checkmark"), for: .normal)
        imageRoutine.image = UIImage(named: "iconMorning")
        titleRoutine.text = "Morning routine"
        btnId = 1
        currPosition = 1
        name = "morning"
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
        imageRoutine.image = UIImage(named: "iconMorningDisabled")
        titleRoutine.attributedText = NSAttributedString(
            string: "Morning routine",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        
        LogRepository.shared.setRoutineAsDone(time: .morning)
        
        // Hide reminder
        delegate?.hideRoutineReminder()
        
        rearrangeStack()
    }
}
