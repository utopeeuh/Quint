//
//  EffectSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 27/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class EffectSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "EffectJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Effects", in: context)!
        
        for (index,subJson):(String, JSON) in json {
            // Do something you want
            
            let newEffect = EffectModel(entity: entity, insertInto: context)
            
            newEffect.id = Int(index)!+1 as NSNumber
            newEffect.title = subJson["Title"].cleanString()
            newEffect.desc = subJson["Description"].cleanString()
            newEffect.icon = subJson["Icon"].cleanString()
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
