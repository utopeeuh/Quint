//
//  RatingCoreSeeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 18/11/22.
//

import Foundation
import UIKit
import CoreData

protocol RatingCoreRepositoryDelegate{
    func getRated(productId: Int) -> Int
}

class RatingCoreRepository: RatingCoreRepositoryDelegate{
   
    static let shared = RatingCoreRepository()
    
    func getRated(productId: Int) -> Int {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Rating")
        
        let predicate = NSPredicate(format: "productId == \(productId)")
        
        request.predicate = predicate
        
        do{
            let results = try context.fetch(request) as? [RatingCoreModel]
            
            if let result = results?.first {
                return Int(truncating: result.rated)
            }
        }
        catch{
            print("fetch user failed")
        }
        
        return 0
    }
    
    func setRated(productId: Int, rated: Int){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Rating")
        
        let predicate = NSPredicate(format: "productId == \(productId)")
        
        request.predicate = predicate
        
        do{
            let results = try context.fetch(request) as? [RatingCoreModel]
            
            if let result = results?.first {
                result.rated = rated as NSNumber
            }
        }
        catch{
            print("Error updating rating")
        }
    }
}
