//
//  IngredientSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class IngredientSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "IngredientsJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Ingredients", in: context)!
        
        for (index,subJson):(String, JSON) in json {
            // Do something you want

            let newIngredient = IngredientModel(entity: entity, insertInto: context)

            newIngredient.id = Int(index)!+1 as NSNumber
            newIngredient.name = subJson["Name"].cleanString()
            newIngredient.alt = subJson["Alt"].cleanString()
            newIngredient.desc = subJson["Description"].cleanString()
            newIngredient.effects = [subJson["Effects"].cleanString()]
            newIngredient.goodNormal = 1
            newIngredient.goodDry = 1
            newIngredient.goodCombi = 1
            newIngredient.goodOily = 1
            newIngredient.allergen = subJson["Allergens"].cleanString()
            newIngredient.usage = subJson["Usage"].cleanString()
            newIngredient.source = subJson["Source"].cleanString()
        }
        
        do{
            try context.save()
            print("Seeding success")
        }
        catch{
            print("Seeding failed")
        }
    }
//    
//    func fetch(){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredients")
//
//        do{
//            let results: NSArray = try context.fetch(request) as NSArray
//            
//            for result in results{
//                let r = result as! IngredientModel
//                print(r.name)
//            }
//        }
//        catch{
//            print("fetch failed")
//        }
//    }

}
