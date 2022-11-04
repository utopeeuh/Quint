//
//  MoodSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 04/11/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class MoodSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "MoodJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Moods", in: context)!
        
        for (index,subJson):(String, JSON) in json {
            // Do something you want
            
            let newMood = MoodModel(entity: entity, insertInto: context)
            
            newMood.id = Int(index)!+1 as NSNumber
            newMood.title = subJson["Title"].cleanString()
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
