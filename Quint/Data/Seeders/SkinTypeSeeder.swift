//
//  SkinTypeSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class SkinTypeSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "SkinTypeJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "SkinTypes", in: context)!
        
        for (index,subJson):(String, JSON) in json {
            // Do something you want

            let newSkinType = SkinTypeModel(entity: entity, insertInto: context)

            newSkinType.id = Int(index)!+1 as NSNumber
            newSkinType.title = subJson["Title"].cleanString()
            newSkinType.desc = subJson["Description"].cleanString()
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
