//
//  UsageStepSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 27/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class UsageStepSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "UsageStepJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "UsageSteps", in: context)!
        
        for (index,subJson):(String, JSON) in json {
            // Do something you want
            
            let newUsageStep = UsageStepModel(entity: entity, insertInto: context)
            
            newUsageStep.id = Int(index)!+1 as NSNumber
            newUsageStep.categoryId = Int(subJson["Category_Id"].cleanString())! as NSNumber
            newUsageStep.title = subJson["Title"].cleanString()
            newUsageStep.desc = subJson["Description"].cleanString()
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
