//
//  CategoriesRepostory.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol CategoriesRepositoryDelegate{
    func fetchCategory(title: String) -> CategoryModel
    func fetchCategory(id: Int) -> CategoryModel
    func fetchCategoryList(ids: [Int]) -> [CategoryModel]
    func fetchUnaddedRoutineCategories(time: K.RoutineTime) -> [CategoryModel]
}

class CategoriesRepository{
    
    static let shared = CategoriesRepository()
    
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
    
    func fetchCategory(id: Int) -> CategoryModel{
        var category = CategoryModel()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        
        let idPredicate = NSPredicate(format: "id == %@", String(describing: id))
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
    
    func fetchCategoryList(ids: [Int]) -> [CategoryModel]{
            
        var categoryList: [CategoryModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        
        var predicateList: [NSPredicate] = []
        ids.forEach { id in
            let idPredicate = NSPredicate(format: "id == %@", String(describing:id))
            predicateList.append(idPredicate)
        }
        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: predicateList)
        
        request.predicate = compoundPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            print(ids)
            
            for result in results {
                let category = result as! CategoryModel
                categoryList.append(category)
            }
            
            categoryList.sort(by: {Int(truncating: $0.id) < Int(truncating: $1.id)})
        }
        catch{
            print("fetch failed")
        }
        
        return categoryList
    }
    
    public func fetchUnaddedRoutineCategories(time: K.RoutineTime) -> [CategoryModel]{
        let allCategoryIds = [1,2,3,4,5,6,7,8,9]
        let allCategories = fetchCategoryList(ids: allCategoryIds)
        let addedSteps = StepsRepository.shared.fetchRoutineSteps(time: time)
        
        var unaddedSteps : [CategoryModel] = []
       
        allCategories.forEach { category in
            if addedSteps.first(where: {$0.title == category.title}) == nil{
                unaddedSteps.append(category)
            }
        }
        
        return unaddedSteps
    }
}
