//
//  TipSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 27/10/22.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

class TipSeeder: Seeder{
    
    required init() {
        super.init()
        self.fileName = "TipJSON"
    }
    
    override func seed(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Tips", in: context)!
        
        for (index, subJson):(String, JSON) in json {
            // Do something you want

            let newTip = TipModel(entity: entity, insertInto: context)

            newTip.id = Int(index)!+1 as NSNumber
            newTip.desc = subJson["Description"].cleanString()
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
