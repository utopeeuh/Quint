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
    func fetchIngredientList() -> [IngredientModel]
    func fetchIngredientList(product: ProductModel) -> [IngredientModel]
    func fetchAllIngredients() -> [IngredientModel]
}

class IngredientsRepository: IngredientsRepositoryDelegate{
    
    static let shared = IngredientsRepository()
    
    func fetchIngredientList(effect: String) -> [IngredientModel]{
        var ingredientList: [IngredientModel] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredients")
        
        let effectPredicate = NSPredicate(format: "effects CONTAINS[c] %@", effect)
        
        if UserRepository.shared.fetchUser().isSensitive {
            let sensPredicate = NSPredicate(format: "avoidIfSens == false")
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [effectPredicate, sensPredicate])
            request.predicate = compoundPredicate
        } else {
            request.predicate = effectPredicate
        }
        
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
    
    func fetchIngredientList() -> [IngredientModel]{
        var ingredientList: [IngredientModel] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredients")
        
        let currUser = UserRepository.shared.fetchUser()
        
        let skinTypesGoodFor = [K.SkinType.normal : "goodNormal",
                                K.SkinType.dry: "goodDry",
                                K.SkinType.oily: "goodOily",
                                K.SkinType.combination: "goodCombination"]
        
        let goodForPredicate = NSPredicate(format: "\(skinTypesGoodFor[Int(truncating: currUser.skinTypeId)]!) != \(K.RecommendationLevel.avoid)")
        
        if currUser.isSensitive {
            let sensPredicate = NSPredicate(format: "avoidIfSens == false")
            let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [goodForPredicate, sensPredicate])
            request.predicate = compoundPredicate
        } else {
            request.predicate = goodForPredicate
        }
        
        do{
            if let results = try context.fetch(request) as? [IngredientModel] {
                ingredientList = results
            }
        }
        catch{
            print("Fetch ingredient list failed")
        }
        
        return ingredientList
    }
    
    func fetchAllIngredients() -> [IngredientModel]{
        var ingredientList: [IngredientModel] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredients")
        
        do{
            if let results = try context.fetch(request) as? [IngredientModel] {
                ingredientList = results
            }
        }
        catch{
            print("Fetch ingredient list failed")
        }
        
        return ingredientList
    }
    
    func fetchIngredientList(product: ProductModel) -> [IngredientModel] {
        
        var productIngredientList : [IngredientModel] = []
        let ingredientList = fetchAllIngredients()
        
        ingredientList.forEach { ingredient in
            
            let productIngredients = product.ingredients.lowercased()
            //Check if ingredient is in product
            if productIngredients.contains(ingredient.name.lowercased()) || (productIngredients.contains(ingredient.alt.lowercased()) && ingredient.alt != "") {
                productIngredientList.append(ingredient)
            }
        }
        
        return productIngredientList
    }
}
