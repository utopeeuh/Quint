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
        
        do{
            let results = try context.fetch(request) as? [UsageStepModel]
            usageStepList = results!
        }
        catch{
            print("fetch usage steps failed")
        }
        
        return usageStepList
    }
    
    func fetchCategory(title: String) -> CategoryModel{
        var category = CategoryModel()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        
        let idPredicate = NSPredicate(format: "title == %@", title)
        request.predicate = idPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            category = (results.firstObject) as! CategoryModel
        }
        catch{
            print("fetch failed")
        }
        
        return category
    }
}
