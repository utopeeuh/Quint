//
//  StepsRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol StepsRepositoryDelegate{
    func createRoutineStep(stepInfo: RoutineStepInfo, time: K.RoutineTime)
    
    func createRoutineStep(category: CategoryModel, isMorning: Bool, position: Int)

    func deleteRoutineStep(step: RoutineStepInfo, time: K.RoutineTime)
    
    func fetchRoutineSteps(time: K.RoutineTime) -> [RoutineStepInfo]
    
    func updateRoutineSteps(steps: [RoutineStepInfo], time: K.RoutineTime)
}

class StepsRepository: StepsRepositoryDelegate{
    
    static let shared = StepsRepository()
    
    func createRoutineStep(stepInfo: RoutineStepInfo, time: K.RoutineTime){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Steps", in: context)!
        
        let routineStep = StepModel(entity: entity, insertInto: context)

        routineStep.routineId = (time == .morning ? K.Routine.morning : K.Routine.night) as NSNumber
        routineStep.categoryId = CategoriesRepository.shared.fetchCategory(title: stepInfo.title).id
        routineStep.position = stepInfo.position as NSNumber
        
        do{
            try context.save()
            print("Create routine step success")
            
        }
        catch{
            print("Create routine step failed")
        }
    }
    
    func createRoutineStep(category: CategoryModel, isMorning: Bool, position: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Steps", in: context)!
        
        let routineStep = StepModel(entity: entity, insertInto: context)

        routineStep.routineId = (isMorning ? K.Routine.morning : K.Routine.night) as NSNumber
        routineStep.categoryId = category.id
        routineStep.position = position as NSNumber
        
        do{
            try context.save()
            print("Create routine step success")
            
        }
        catch{
            print("Create routine step failed")
        }
        
    }

    func deleteRoutineStep(step: RoutineStepInfo, time: K.RoutineTime){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Steps")
        
        var routineId = K.Routine.morning
        if time == K.RoutineTime.night{
            routineId = K.Routine.night
        }
        
        let timePredicate = NSPredicate(format: "routineId == %@", String(describing: routineId))
        let idPredicate = NSPredicate(format: "position == %@", String(describing: step.position))
        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: [timePredicate, idPredicate])
        
        request.predicate = compoundPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            context.delete(results.firstObject as! NSManagedObject)
        }
        catch{
            print("fetch failed")
        }
    }
    
    func fetchRoutineSteps(time: K.RoutineTime) -> [RoutineStepInfo]{
        var stepInfoList: [RoutineStepInfo] = []
        var stepList: [StepModel] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Steps")
        
        var routineId = K.Routine.morning
        if time == K.RoutineTime.night{
            routineId = K.Routine.night
        }
        
        let timePredicate = NSPredicate(format: "routineId == %@", String(describing: routineId))
        request.predicate = timePredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                let step = result as? StepModel
                stepList.append(step!)
            }
            
            stepList.forEach { step in
                let currCat = CategoriesRepository.shared.fetchCategory(id: Int(truncating: step.categoryId))
                stepInfoList.append(RoutineStepInfo(title: currCat.title, position: Int(truncating: step.position)))
            }
        }
        catch{
            print("fetch failed")
        }
        return stepInfoList
    }
    
    func updateRoutineSteps(steps: [RoutineStepInfo], time: K.RoutineTime){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Steps")
        
        var routineId = K.Routine.morning
        if time == K.RoutineTime.night{
            routineId = K.Routine.night
        }
        
        let timePredicate = NSPredicate(format: "routineId == %@", String(describing: routineId))
        request.predicate = timePredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                context.delete(result as! NSManagedObject)
            }
            
            steps.forEach { step in
                createRoutineStep(stepInfo: step, time: time)
            }
        }
        catch{
            print("fetch failed")
        }
    }
}
