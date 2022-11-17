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
    
//    func fetchUser() -> UserModel {
//        var user = UserModel()
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//
//        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//
//        do{
//            let userResults:NSArray = try context.fetch(userRequest) as NSArray
//            user = (userResults.firstObject as? UserModel)!
//        }
//        catch{
//            print("fetch user failed")
//        }
//
//        return user
//    }
    func fetchProblemList() -> [ProblemModel]{

        var problemList: [ProblemModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Problems")
        do{
            if let results = try context.fetch(request) as? [ProblemModel] {
                problemList = results
            }
        }
        catch{
            print("fetch failed")
        }

        return problemList
    }

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
    
    func fetchProblemIsActive() -> [ProblemModel] {
        
        var problemList: [ProblemModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Problems")

        let isActivePredicate = NSPredicate(format: "isActive == true")
        request.predicate = isActivePredicate
        
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
    
    func updateSkinProblem(ids: [Int]) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

        let allProblems = fetchProblemList()
        let activeProblems = fetchProblemList(ids: ids)

        allProblems.forEach { problem in
            if activeProblems.contains(problem){
                problem.isActive = true
            } else {
                problem.isActive = false
            }
        }

        do{
            try context.save()
        }
        catch{
            print("update skin problem failed")
        }

    }
    
}
