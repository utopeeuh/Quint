//
//  SkinTypesRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol SkinTypesRepositoryDelegate {
    func fetchSkinType(id: Int) -> SkinTypeModel
}

class SkinTypesRepository: SkinTypesRepositoryDelegate{
    
    static let shared = SkinTypesRepository()
    
    public func fetchSkinType(id: Int) -> SkinTypeModel{
            
        var skinType: SkinTypeModel?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SkinTypes")
        let idPredicate = NSPredicate(format: "id == \(id)")
        print(id)
        request.predicate = idPredicate
        
        do{
            let results = try context.fetch(request) as? [SkinTypeModel]
            
            skinType = results?.first
            
            print(results)
            
        }
        catch{
            print("fetch failed")
        }
        
        return skinType!
    }
    
}

