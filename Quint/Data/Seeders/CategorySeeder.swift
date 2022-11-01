//
//  CategorySeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 27/10/22.
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
            
            let newCat = CategoryModel(entity: entity, insertInto: context)
            
            newCat.id = Int(index)!+1 as NSNumber
            newCat.title = subJson["Title"].cleanString()
            newCat.isDay = (subJson["IsDay"]).rawValue as! NSNumber
            newCat.isNight = (subJson["IsNight"]).rawValue as! NSNumber
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
