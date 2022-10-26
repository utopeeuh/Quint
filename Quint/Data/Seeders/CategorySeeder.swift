//
//  CategorySeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class CategorySeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "CategoryJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Categories", in: context)!
        
        for (index,subJson):(String, JSON) in json {
            // Do something you want

            let newCategory = CategoryModel(entity: entity, insertInto: context)

            newCategory.id = Int(index)!+1 as NSNumber
            newCategory.title = subJson["Title"].cleanString()
            newCategory.desc = subJson["Description"].cleanString()
            newCategory.icon = subJson["Icon"].cleanString()
            newCategory.guideSteps = ["sdsd": "asdasd"]
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
