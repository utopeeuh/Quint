//
//  String+NoneIfEmpty.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 16/11/22.
//

import Foundation
import UIKit

extension String {
    func setNoneIfEmpty() -> String {
        if self == "" {
            return "None"
        }
        
        return self
    }
}
