//
//  UsageStepsRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol UsageStepsRepositoryDelegate{
    func fetchUsageSteps(categoryId: Int) -> [UsageStepModel]
}

class UsageStepsRepository: UsageStepsRepositoryDelegate{
    
    static let shared = UsageStepsRepository()
    
    func fetchUsageSteps(categoryId: Int) -> [UsageStepModel] {
        var usageStepList : [UsageStepModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UsageSteps")
        
        let categoryPredicate = NSPredicate(format: "categoryId == %@", categoryId as NSNumber)
        request.predicate = categoryPredicate
        
        let sortById = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortById]
        
        do{
            let results = try context.fetch(request) as? [UsageStepModel]
            usageStepList = results!
        }
        catch{
            print("fetch usage steps failed")
        }
        
        return usageStepList
    }
}
