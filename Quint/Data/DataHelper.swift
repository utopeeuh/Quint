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

        let problems = ProblemsRepository.shared.fetchProblemList(ids: data.skinProblems!)
        let user = UserRepository.shared.fetchUser()
        let routineCategories = CategoriesRepository.shared.fetchCategoryList(ids: data.routineCategoryList)
        
        do{
            //  Set user skin type and sensitivity
            user.isSensitive = data.isSensitive!
            user.skinTypeId = data.selectedSkinType! as NSNumber
            
            //  Set problems as active
            problems.forEach { problem in
                problem.isActive = true
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
    
    func clearDatabase(entityName: String) {

        let persistentContainer = NSPersistentContainer(name: entityName)
        guard let url = persistentContainer.persistentStoreDescriptions.first?.url else { return }
        
        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator

         do {
             try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
             try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
         } catch {
             print("Attempted to clear persistent store: " + error.localizedDescription)
         }
    }
}
