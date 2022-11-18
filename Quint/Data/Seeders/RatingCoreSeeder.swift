//
//  RatingCoreSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 18/11/22.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

class RatingCoreSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "ProductsJSON"
    }
    
    override func seed() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Rating", in: context)!
        
        for (index,_):(String, JSON) in json {
            // Do something you want

            let newRatingCore = RatingCoreModel(entity: entity, insertInto: context)

            newRatingCore.productId = Int(index)!+1 as NSNumber
            newRatingCore.rated = 0
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
