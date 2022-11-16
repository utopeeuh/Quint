//
//  ProductRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol ProductsRepositoryDelegate{
    func generateRecommendedProducts()
    func fetchAllProducts() -> [ProductModel]
    func fetchProducts(categoryId: Int) -> [ProductModel]
}

class ProductsRepository: ProductsRepositoryDelegate{

    static let shared = ProductsRepository()
    
    func fetchAllProducts() -> [ProductModel] {
        
        var productList : [ProductModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")

        do{
            if let results = try context.fetch(request) as? [ProductModel] {
                productList = results
            }
        }
        catch{
            print("Fetch products failed")
        }

        return productList
    }
    
    // Run this right after onboarding
    func generateRecommendedProducts(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let currUser = UserRepository.shared.fetchUser()
        let allIngredients = IngredientsRepository.shared.fetchAllIngredients()
        let productList = fetchAllProducts()
    
        // loop through all products
        productLoop: for product in productList {
            
            var matchingIngredients = 0
            var isRecommended = true
            
            // loop through all ingredients
            ingredientLoop: for ingredient in allIngredients {
                
                let ingredientList = product.ingredients.lowercased()
                
                // check if ingredient found in product
                if ingredientList.contains(ingredient.name.lowercased()) || (ingredient.alt != "" && ingredientList.contains(ingredient.alt.lowercased())) {
                    
                    // check if ingredient is bad for user's skin
                    let goodForDict = [ K.SkinType.normal : ingredient.goodNormal,
                                        K.SkinType.dry : ingredient.goodDry,
                                        K.SkinType.oily : ingredient.goodOily,
                                        K.SkinType.combination : ingredient.goodCombination
                                    ]
                    
                    // check if ingredient is bad for skin
                    if goodForDict[Int(truncating: currUser.skinTypeId)] == K.RecommendationLevel.avoid  {
                        isRecommended = false
                        break ingredientLoop
                    }
                    
                    // check if ingredient should be avoided if sensitive
                    if ingredient.avoidIfSens && currUser.isSensitive {
                        isRecommended = false
                        break ingredientLoop
                    }
                    
                    matchingIngredients += 1
                }
            }
            
            product.isRecommended = isRecommended
            
            if product.isRecommended {
                // fetch product ratings here
                
                // update matching ingredients
                product.matchingIngredients = matchingIngredients as NSNumber
            }
        }
        
        // Save context
        do{
            try context.save()
            print("Finished generating recommended products")
        }
        catch{
            print("Failed generating recommended products")
        }
        
    }
    
    // Make sure generate is done before calling
    func fetchProducts(categoryId: Int) -> [ProductModel] {
        
        var productList : [ProductModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
        
        let recommendedPredicate = NSPredicate(format: "isRecommended == true")
        let categoryPredicate = NSPredicate(format: "categoryId == \(categoryId)")
        let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [recommendedPredicate, categoryPredicate])
        
        let matchingSort = NSSortDescriptor(key: "matchingIngredients", ascending: false)
        
        request.predicate = compoundPredicate
        request.sortDescriptors = [matchingSort]

        do{
            if let results = try context.fetch(request) as? [ProductModel] {
                productList = results
            }
        }
        catch{
            print("Fetch products failed")
        }

        return productList
    }
    
}
