//
//  LogsRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol LogRepositoryDelegate{
    func setRoutineAsDone(time: K.RoutineTime)
    func doesLogExists(date: Date) -> Bool
    func fetchLog(date: Date) -> LogModel
    func createLog(date: Date)
}

class LogRepository: LogRepositoryDelegate{
    
    static let shared = LogRepository()
    
    func fetchLog(date: Date) -> LogModel {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Logs")
        
        let datePredicate = NSPredicate(format: "date == %@",  Locale.current.calendar.startOfDay(for: date) as CVarArg)
        
        request.predicate = datePredicate
        
        do{
            let results = try context.fetch(request) as? [LogModel]
            return results!.first!
        }
        catch{
            print("fetch failed")
        }
        
        return LogModel()
    }
    
    func doesLogExists(date: Date) -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Logs")
        
        
        let datePredicate = NSPredicate(format: "date == %@", Locale.current.calendar.startOfDay(for: date) as CVarArg)
        
        request.predicate = datePredicate
        
        do{
            let results = try context.fetch(request) as? [LogModel]
            
            return results?.isEmpty ?? true ? false : true
        }
        catch{
            print("fetch failed")
        }
        
        return false
    }
    
    func createLog(date: Date){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Logs", in: context)!
        
        let newLog = LogModel(entity: entity, insertInto: context)
        
        newLog.date = Locale.current.calendar.startOfDay(for: date)
        newLog.isLogDone = false
        newLog.isDayDone = false
        newLog.isNightDone = false
       
        do{
            try context.save()
            print("Create new log success")
        }
        catch{
            print("Create new log failed")
        }
    }
    
    func setRoutineAsDone(time: K.RoutineTime){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        //if log doesnt exist
            // create
        // fetch
        // update isDone
        
        if !doesLogExists(date: Date.now){
            createLog(date: Date.now)
            print(doesLogExists(date: Date.now))
        }
        
        let currDayLog = fetchLog(date: Date.now)
        
        switch time {
        case .morning:
            currDayLog.isDayDone = true
        default:
            currDayLog.isNightDone = true
        }
        
        do{
            try context.save()
            print("Set routine as done success")
        }
        catch{
            print("Set routine as done failed")
        }
    }
}
