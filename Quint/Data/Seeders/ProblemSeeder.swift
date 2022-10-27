//
//  ProblemSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class ProblemSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "ProblemJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Problems", in: context)!
        
        for (index,subJson):(String, JSON) in json {
            // Do something you want

            let newProblem = ProblemModel(entity: entity, insertInto: context)

            newProblem.id = Int(index)!+1 as NSNumber
            newProblem.title = subJson["Title"].cleanString()
            newProblem.desc = subJson["Description"].cleanString()
            newProblem.isActive = false
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
