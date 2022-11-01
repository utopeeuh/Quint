//
//  DataHelper.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import CoreData

class DataHelper{
    
    static let shared = DataHelper()
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    
    init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    public func fetchProblems(problemIds: [Int]) -> [ProblemModel]{
            
        var problemList: [ProblemModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Problems")
        
        var predicateList: [NSPredicate] = []
        problemIds.forEach { id in
            let idPredicate = NSPredicate(format: "id == %@", String(describing:id+1))
            predicateList.append(idPredicate)
        }
        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: predicateList)
        
        request.predicate = compoundPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                let problem = result as? ProblemModel
                problemList.append(problem!)
            }
            
            return problemList
        }
        catch{
            print("fetch failed")
        }
        
        return problemList
    }
    
    func fetchCategoryListById(categoryIds: [Int]) -> [CategoryModel]{
            
        var categoryList: [CategoryModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        
        var predicateList: [NSPredicate] = []
        categoryIds.forEach { id in
            let idPredicate = NSPredicate(format: "id == %@", String(describing:id))
            predicateList.append(idPredicate)
        }
        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: predicateList)
        
        request.predicate = compoundPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            print(categoryIds)
            
            for result in results {
                let category = result as! CategoryModel
                categoryList.append(category)
            }
        }
        catch{
            print("fetch failed")
        }
        
        return categoryList
    }
    
    func fetchIngredientListByEffect(effect: String) -> [IngredientModel]{
        var ingredientList: [IngredientModel] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredients")
        
        let effectPredicate = NSPredicate(format: "effects CONTAINS[c] %@", effect)
        
        request.predicate = effectPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                let ingredient = result as! IngredientModel
                ingredientList.append(ingredient)
            }
        }
        catch{
            print("fetch failed")
        }
        
        return ingredientList
    }
    
    func fetchEffectList(effectIds: [Int]) -> [EffectModel]{
            
        var effectList: [EffectModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Effects")
        
        var predicateList: [NSPredicate] = []
        effectIds.forEach { id in
            let idPredicate = NSPredicate(format: "id == %@", String(describing:id))
            predicateList.append(idPredicate)
        }
        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: predicateList)
        
        request.predicate = compoundPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                let effect = result as? EffectModel
                effectList.append(effect!)
            }
        }
        catch{
            print("fetch failed")
        }
        
        return effectList
    }
    
    public func fetchSkinType(id: Int) -> SkinTypeModel{
            
        var skinType: SkinTypeModel?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SkinTypes")
        let idPredicate = NSPredicate(format: "id == %@", String(describing:id+1))
        request.predicate = idPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                skinType  = result as? SkinTypeModel
            }
            
            return skinType!
        }
        catch{
            print("fetch failed")
        }
        
        return skinType!
    }
    
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
