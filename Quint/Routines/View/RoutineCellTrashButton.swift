//
//  RoutineCellTrashButton.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 03/11/22.
//

import Foundation
import UIKit

class RoutineCellTrashButton: UIButton{
    
    var cellTitle : String?
    
    required init() {
        super.init(frame: .zero)
        
        frame = CGRect(x: 0, y: 0, width: 14, height: 18)
        setImage(UIImage(named: "TrashIcon"), for: .normal)
        setTitle("", for: .normal)
        alpha = 0
        isEnabled = false
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
