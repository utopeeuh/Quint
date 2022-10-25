//
//  DataHelper.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import CoreData


let dataHelper = DataHelper()

class DataHelper{
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    
    init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    
//    func addParty(_ partyList: [PartyModel]) -> [PartyModel]{
//            var newPartyList = partyList
//            
//            let entity = NSEntityDescription.entity(forEntityName: "PartyModel", in: context)
//            let newParty = PartyModel(entity: entity!, insertInto: context)
//            
//            newParty.id = newPartyList.count as NSNumber
//            
//            do{
//                try context.save()
//                newPartyList.append(newParty)
//                print("Added new party")
//            }
//            catch{
//                print("context add party save error")
//            }
//            
//            return newPartyList
//        }
    
    func clearDatabase(entityName: String) {

        let persistentContainer = NSPersistentContainer(name: entityName)
        guard let url = persistentContainer.persistentStoreDescriptions.first?.url else { return }
        
        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator

         do {
             try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
             try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
         } catch {
             print("Attempted to clear persistent store: " + error.localizedDescription)
         }
    }
}
