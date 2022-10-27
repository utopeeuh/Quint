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
    let seeders = [IngredientSeeder(), EffectSeeder(), CategorySeeder(), UsageStepSeeder(), ProductSeeder(), SkinTypeSeeder(), ProblemSeeder(), RoutineSeeder(), UserSeeder(), TipSeeder()]
    
    override func viewDidLoad() {
        seeders.forEach { seeder in
            seeder.seedFromJson()
        }
    }
}
