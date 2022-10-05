//
//  Constants.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/10/22.
//

import Foundation
import UIKit

struct K{
    // offset valuesnya masih ngasal nanti benerin aja
    struct Offset{
        static let lg = 28
        static let md = 16
        static let sm = 4
    }
    
    struct Color{
        static let lgreen = UIColor(red: 255, green: 87, blue: 51, alpha: 1)
        static let lyellow = UIColor(red: 255, green: 211, blue: 99, alpha: 1)
        static let lorange = UIColor(red: 255, green: 149, blue: 73, alpha: 1)
        static let lred = UIColor(red: 255, green: 99, blue: 99, alpha: 1)
        static let lpurple = UIColor(red: 169, green: 99, blue: 255, alpha: 1)
        
        static let green = UIColor(red: 29, green: 53, blue: 44, alpha: 1)
        static let yellow = UIColor(red: 239, green: 179, blue: 28, alpha: 1)
        static let orange = UIColor(red: 243, green: 106, blue: 7, alpha: 1)
        static let red = UIColor(red: 199, green: 59, blue: 59, alpha: 1)
        static let purple = UIColor(red: 121, green: 31, blue: 238, alpha: 1)
    }
    
    struct identifiers {
        static let apiUrl = "https://dummyapi.io/data/api/"
        static let apiKey = "5fa160451843ad228d0a1c7c"
        static let photosApi = "https://picsum.photos/v2/list"
    }
}


