//
//  IngredientsRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol IngredientsRepositoryDelegate{
    func fetchIngredientList(effect: String) -> [IngredientModel]
}

class IngredientsRepository: IngredientsRepositoryDelegate{
    
    static let shared = IngredientsRepository()
    
    func fetchIngredientList(effect: String) -> [IngredientModel]{
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
}
