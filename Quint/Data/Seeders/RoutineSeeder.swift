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
        self.fileName = ""
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Routines", in: context)!
        
        let morningRoutine = RoutineModel(entity: entity, insertInto: context)

        morningRoutine.id = 1
        morningRoutine.title = "Morning"
        
//        let nightRoutine = RoutineModel(entity: entity, insertInto: context)
//        
//        nightRoutine.id = 2
//        nightRoutine.title = "Night"
//        
        do{
            try context.save()
            print("Seeding success")
            
        }
        catch{
            print("Seeding failed")
        }
    }
}
