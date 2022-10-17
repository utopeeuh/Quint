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
        static let bgQuint = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        static let whiteQuint = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        static let blackQuint = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        static let greyQuint = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        static let greyDarkQuint = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        
        static let greenLightQuint = UIColor(red: 255/255, green: 87/255, blue: 51/255, alpha: 1)
        static let yellowLightQuint = UIColor(red: 255/255, green: 211/255, blue: 99/255, alpha: 1)
        static let orangeLightQuint = UIColor(red: 255/255, green: 149/255, blue: 73/255, alpha: 1)
        static let redLightQuint = UIColor(red: 255/255, green: 99/255, blue: 99/255, alpha: 1)
        static let purpleLightQuint = UIColor(red: 169/255, green: 99/255, blue: 255/255, alpha: 1)
        
        static let greenQuint = UIColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        static let yellowQuint = UIColor(red: 239/255, green: 179/255, blue: 28/255, alpha: 1)
        static let orangeQuint = UIColor(red: 243/255, green: 106/255, blue: 7/255, alpha: 1)
        static let redQuint = UIColor(red: 199/255, green: 59/255, blue: 59/255, alpha: 1)
        static let purpleQuint = UIColor(red: 121/255, green: 31/255, blue: 238/255, alpha: 1)
        
        static let shadowQuint = UIColor(red: 16/255, green: 24/255, blue: 40/255, alpha: 0.05)
        static let greenButtonQuint = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        static let disableBgBtnQuint = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        static let disableTextBtnQuint = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
    }
    
    struct identifiers {
        static let apiUrl = "https://dummyapi.io/data/api/"
        static let apiKey = "5fa160451843ad228d0a1c7c"
        static let photosApi = "https://picsum.photos/v2/list"
    }
    
    struct Category{
        
        static let skinProblem = [1: "Acne", 2: "Black heads", 3: "Dark circles", 4: "Dryness", 5: "Dullness", 6: "Oiliness", 7: "Redness", 8: "Uneven texture"]
        
        static let product = [1: "Toner", 2: "Serum", 3: "Eye Care", 4: "Acne Treatment", 5: "Face Wash", 6: "Face Scrub", 7: "Micellar Water", 8: "Moisturizer", 9: "Sunscreen"]
        
        static let ingredient = [1: "Anti-acne", 2: "Anti-aging", 3: "Anti-bacterial", 4: "Anti-inflammatory", 5: "Brightening", 6: "Hydrating", 7: "Moisturizing", 8: "pH Balancer", 9: "Soothing", 10: "UV Protection"]
        
    }
    
    struct Dummy{
        static let ingredient = [1: "Salicylic Acid", 2: "Benzoyl peroxide", 3: "Adapalene", 4: "Lauric Acid", 5: "Sulfur", 6: "Zinc gluconate"]
    }

    struct Box {
        var title: String?
        var desc: String?
    }
    
}


