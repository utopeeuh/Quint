//
//  DataHelper.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import CoreData

class DataHelper{
    
    static let shared = DataHelper()
    
    var appDelegate: AppDelegate!
    var context: NSManagedObjectContext!
    
    init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    public func saveOnboardingData(data: OnboardingData){

        let allProblems = ProblemsRepository.shared.fetchProblemList()
        let problems = ProblemsRepository.shared.fetchProblemList(ids: data.skinProblems!)
        let user = UserRepository.shared.fetchUser()
        let routineCategories = CategoriesRepository.shared.fetchCategoryList(ids: data.routineCategoryList)
        
        do{
            //  Set user skin type and sensitivity
            user.isSensitive = data.isSensitive!
            user.skinTypeId = data.selectedSkinType! as NSNumber
            
            //  Set problems as active
            
            allProblems.forEach { problem in
                problem.isActive = false
                if problems.contains(problem){
                    problem.isActive = true
                }
            }
            
            // Update routines
            let stepRepo = StepsRepository.shared
            var morningPosition: Int = 1
            var nightPosition: Int = 1
            routineCategories.forEach { category in
                if (category.isDay as! Bool){
                    stepRepo.createRoutineStep(category: category, isMorning: true, position: morningPosition)
                    morningPosition += 1
                }
                
                if (category.isNight as! Bool){
                    stepRepo.createRoutineStep(category: category, isMorning: false, position: nightPosition)
                    nightPosition += 1
                }
            }
            
            //  Create log with chosen image
            if(data.chosenImage != nil){
                LogRepository.shared.createLog(date: Date.now)
                LogRepository.shared.insertImage(date: Date.now, image: data.chosenImage!)
            }
            
            try context.save()
        }
        catch{
            print("update onboarding data failed")
        }
    }
    
    func clearDatabase() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // Delete logs, user and routine steps
        
        let logRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Logs")
        
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        let stepsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Steps")
        
        // Set problems to inactive
        let problemsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Problems")
        
        do{
            let logResults:NSArray = try context.fetch(logRequest) as NSArray
            
            let userResults:NSArray = try context.fetch(userRequest) as NSArray
            
            let stepsResults:NSArray = try context.fetch(stepsRequest) as NSArray
            
            let problemResults = try context.fetch(stepsRequest) as? [ProblemModel]
            
            logResults.forEach { log in
                context.delete(log as! NSManagedObject)
            }
            
            context.delete(userResults.firstObject as! NSManagedObject)
            
            stepsResults.forEach { step in
                context.delete(step as! NSManagedObject)
            }
            
            problemResults?.forEach { problem in
                problem.isActive = false
            }
            
            try context.save()
        }
        catch{
            print("Delete data failed")
        }
    }
}
