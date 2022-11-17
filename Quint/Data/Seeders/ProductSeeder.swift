//
//  ProductSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 26/10/22.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

class ProductSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "ProductsJSON"
    }
    
    override func seed() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Products", in: context)!
        
        for (index,subJson):(String, JSON) in json {
            // Do something you want

            let newProduct = ProductModel(entity: entity, insertInto: context)

            newProduct.id = Int(index)!+1 as NSNumber
            newProduct.categoryId = Int(subJson["Category_id"].cleanString())! as NSNumber
            newProduct.brand = subJson["Brand"].cleanString()
            newProduct.name = subJson["Name"].cleanString()
            newProduct.price = subJson["Price"].cleanString()
            newProduct.url = subJson["Url"].cleanString()
            newProduct.image = subJson["Image"].cleanString()
            newProduct.ingredients = subJson["Ingredients"].cleanString()
            
            newProduct.matchingIngredients = 0
            newProduct.isRecommended = false
        }
        
        do{
            try context.save()
            print("Seeding success")
        }
        catch{
            print("Seeding failed")
        }
    }
}
