//
//  dummy.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import CoreData

class dummy: UIViewController{
    let seeder = IngredientSeeder()
    let seederIng = ProductSeeder()
    override func viewDidLoad() {
        seeder.seedFromJson()
        seederIng.seedFromJson()
//        seeder.fetch()
    }
}
