//
//  ActivitySeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class ActivitySeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "ActivityJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Activities", in: context)!
        
        for (index,subJson):(String, JSON) in json {
            // Do something you want

            let newActivity = ActivityModel(entity: entity, insertInto: context)

            newActivity.id = Int(index)!+1 as NSNumber
            newActivity.title = subJson["Title"].cleanString()
            newActivity.desc = subJson["Description"].cleanString()
            newActivity.icon = subJson["Icon"].cleanString()
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
