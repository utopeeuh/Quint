//
//  RoutineSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class RoutineSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "RoutineJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Routines", in: context)!
        
        for (index,_):(String, JSON) in json {
            // Do something you want

            let newRoutine = RoutineModel(entity: entity, insertInto: context)

            newRoutine.id = Int(index)!+1 as NSNumber
            newRoutine.stepIds = [1,2,3]
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
