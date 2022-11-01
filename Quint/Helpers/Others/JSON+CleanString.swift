//
//  JSON+CleanString.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import SwiftyJSON

extension JSON{
    func cleanString() -> String{
        let newString : String = (self as AnyObject).description
        if(newString == "-"){
            return ""
        }
        return newString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}
