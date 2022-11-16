//
//  EffectsRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol EffectsRepositoryDelegate{
    func fetchEffectList() -> [EffectModel]
    func fetchEffectList(ids: [Int]) -> [EffectModel]
}

class EffectsRepository: EffectsRepositoryDelegate{
    
    static let shared = EffectsRepository()
    
    func fetchEffectList(ids: [Int]) -> [EffectModel]{
            
        var effectList: [EffectModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Effects")
        
        var predicateList: [NSPredicate] = []
        ids.forEach { id in
            let idPredicate = NSPredicate(format: "id == %@", String(describing:id))
            predicateList.append(idPredicate)
        }
        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: predicateList)
        
        request.predicate = compoundPredicate
        
        let idSort = NSSortDescriptor(key:"id", ascending:true)
        request.sortDescriptors = [idSort]
        
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
    
    func fetchEffectList() -> [EffectModel]{
            
        var effectList: [EffectModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Effects")
        
        let idSort = NSSortDescriptor(key:"id", ascending:true)
        request.sortDescriptors = [idSort]
        
        do{
            if let results = try context.fetch(request) as? [EffectModel]{
                effectList = results
            }
        }
        catch{
            print("fetch failed")
        }
        
        return effectList
    }
}
