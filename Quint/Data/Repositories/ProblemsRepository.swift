//
//  ProblemsRepostitory.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol ProblemsRepositoryDelegate{
    func fetchProblemList(ids: [Int]) -> [ProblemModel]
}

class ProblemsRepository: ProblemsRepositoryDelegate{
    
    static let shared = ProblemsRepository()
    
    func fetchProblemList(ids: [Int]) -> [ProblemModel]{
            
        var problemList: [ProblemModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Problems")
        
        var predicateList: [NSPredicate] = []
        ids.forEach { id in
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
}
