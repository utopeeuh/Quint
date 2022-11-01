//
//  Constants.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 05/10/22.
//

import Foundation
import UIKit

struct K{
    
    struct Offset{
        static let lg = 28
        static let md = 16
        static let sm = 4
    }
    
    struct Color{
        static let bgQuint = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        static let whiteQuint = UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)
        static let blackQuint = UIColor(red: 7/255, green: 8/255, blue: 7/255, alpha: 1)
        static let greyDarkQuint = UIColor(red: 35/255, green: 36/255, blue: 35/255, alpha: 1)
        static let greyQuint = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        
        static let greenLightQuint = UIColor(red: 53/255, green: 84/255, blue: 73/255, alpha: 1)
        static let yellowLightQuint = UIColor(red: 255/255, green: 211/255, blue: 99/255, alpha: 1)
        static let orangeLightQuint = UIColor(red: 255/255, green: 161/255, blue: 92/255, alpha: 1)
        static let redLightQuint = UIColor(red: 255/255, green: 99/255, blue: 99/255, alpha: 1)
        static let purpleLightQuint = UIColor(red: 169/255, green: 99/255, blue: 255/255, alpha: 1)
        static let blueLightQuint = UIColor(red: 45/255, green: 61/255, blue: 119/255, alpha: 1)
        
        static let greenQuint = UIColor(red: 29/255, green: 53/255, blue: 44/255, alpha: 1)
        static let yellowQuint = UIColor(red: 239/255, green: 179/255, blue: 28/255, alpha: 1)
        static let orangeQuint = UIColor(red: 242/255, green: 105/255, blue: 6/255, alpha: 1)
        static let redQuint = UIColor(red: 199/255, green: 59/255, blue: 59/255, alpha: 1)
        static let purpleQuint = UIColor(red: 121/255, green: 31/255, blue: 238/255, alpha: 1)
        static let blueQuint = UIColor(red: 11/255, green: 28/255, blue: 87/255, alpha: 1)
        
        static let shadowQuint = UIColor(red: 16/255, green: 24/255, blue: 40/255, alpha: 0.05)
        static let disableBgBtnQuint = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        static let disableTextBtnQuint = UIColor(red: 125/255, green: 125/255, blue: 125/255, alpha: 1)
        static let greenSkinProblemQuint = UIColor(red: 172/255, green: 203/255, blue: 192/255, alpha: 1)
        static let redSkinProblemQuint = UIColor(red: 255/255, green: 224/255, blue: 224/255, alpha: 1)
        static let greyWhiteQuint = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
    
    struct identifiers {
        static let apiUrl = "https://dummyapi.io/data/api/"
        static let apiKey = "5fa160451843ad228d0a1c7c"
        static let photosApi = "https://picsum.photos/v2/list"
    }
    
    static let defaultRoutineOnboarding = [ProductCategory.cleanser
                                           ,ProductCategory.toner
                                           ,ProductCategory.serum
                                           ,ProductCategory.eyeCare
                                           ,ProductCategory.moisturizer
                                           ,ProductCategory.acneCare
                                           ,ProductCategory.sunscreen]
    
    struct ProductCategory{
        static let cleanser = 1
        static let toner = 2
        static let serum = 3
        static let eyeCare = 4
        static let moisturizer = 5
        static let acneCare = 6
        static let sunscreen = 7
        static let exfoliator = 8
        static let micellar = 9
    }
    
    struct Problem{
        static let acne = 1
        static let blackHeads = 2
        static let darkCircles = 3
        static let dryness = 4
        static let dullness = 5
        static let oiliness = 6
        static let redness = 7
        static let unevenTexture = 8
    }
    
    struct Effect{
        static let antiAcne = 1
        static let antiAging = 2
        static let antiBacterial = 3
        static let brightening = 4
        static let hydrating = 5
        static let moisturizing = 6
        static let phBalancing = 7
        static let soothing = 8
        static let uvProtection = 9
    }
    
    struct Category{
        
        static let skinProblem = [1: "Acne", 2: "Black heads", 3: "Dark circles", 4: "Dryness", 5: "Dullness", 6: "Oiliness", 7: "Redness", 8: "Uneven texture"]
        
        static let product = [1: "Toner", 2: "Serum", 3: "Eye Care", 4: "Acne Treatment", 5: "Face Wash", 6: "Face Scrub", 7: "Micellar Water", 8: "Moisturizer", 9: "Sunscreen"]
        
        static let productGuide = [1: "Cleanser", 2: "Serum", 3: "Eye Care", 4: "Acne Care", 5: "Toner", 6: "Micellar", 7: "Moisturizer", 8: "Sunscreen"]

        static let productGuideImageName = [1: "cleanser", 2: "serum", 3: "eyeCare", 4: "acneCare", 5: "toner", 6: "micellar", 7: "moisturizer", 8: "sunScreen"]

        static let ingredient = [1: "Anti-acne", 2: "Anti-aging", 3: "Anti-bacterial", 4: "Anti-inflammatory", 5: "Brightening", 6: "Hydrating", 7: "Moisturizing", 8: "pH Balancer", 9: "Soothing", 10: "UV Protection"]
        
        static let skincareSteps: [SkinEssential] = [
        
            SkinEssential(title: "Cleanser", partOfDay: .all),
            SkinEssential(title: "Toner", partOfDay: .all),
            SkinEssential(title: "Serum", partOfDay: .all),
            SkinEssential(title: "Eye care", partOfDay: .night),
            SkinEssential(title: "Moisturizer", partOfDay: .all),
            SkinEssential(title: "Acne care", partOfDay: .night),
            SkinEssential(title: "Sunscreen", partOfDay: .morning)
        
        ]
    }
    
    struct Dummy{
        static let ingredient = [1: "Salicylic Acid", 2: "Benzoyl peroxide", 3: "Adapalene", 4: "Lauric Acid", 5: "Sulfur", 6: "Zinc gluconate"]
    }
    
    struct CategoryImage{
        static let ingredient = [1: UIImage(named: "AntiAcneCategory"), 2: UIImage(named: "AntiAgingCategory"), 3: UIImage(named: "AntiBacterialCategory"), 4: UIImage(named: "BrighteningCategory"), 5: UIImage(named: "HydratingCategory"), 6: UIImage(named: "MoisturizingCategory"), 7: UIImage(named: "PhBalanceCategory"), 8: UIImage(named: "SoothingCategory"), 9: UIImage(named: "UVCategory")]
    }
    
    struct Rated{
        static let none = 0
        static let up = 1
        static let down = 2
    }
    
    enum PartOfDay {
        case morning
        case night
        case all
    }
    
    struct SkinEssential {
        var title: String
        var partOfDay: PartOfDay
    }
    
    struct UD{
        static let firstTime = "FIRST_TIME_OPEN"
    }
}


