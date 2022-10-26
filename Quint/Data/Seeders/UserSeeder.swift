//
//  UserSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class UserSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = ""
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "User", in: context)!
        
        let newUser = UserModel(entity: entity, insertInto: context)

        newUser.skinTypeId = 1
        newUser.isSensitive = true
        newUser.problemIds = [1,2,3]
        
        
        do{
            try context.save()
            print("Seeding success")
        }
        catch{
            print("Seeding failed")
        }
    }
}
