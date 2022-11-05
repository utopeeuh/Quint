//
//  RoutinesRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol RoutinesRepositoryDelegate{
    func fetchRoutines() -> [RoutineModel]
}

class RoutinesRepository: RoutinesRepositoryDelegate{
    
    static let shared = RoutinesRepository()
    
    public func fetchRoutines() -> [RoutineModel]{
            
        var routineList: [RoutineModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Routines")
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                let routine = result as? RoutineModel
                routineList.append(routine!)
            }
            
            return routineList
        }
        catch{
            print("fetch routines failed")
        }
        
        return routineList
    }
}
