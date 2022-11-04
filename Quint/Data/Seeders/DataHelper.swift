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

        let problems = fetchProblems(problemIds: data.skinProblems!)
        let user = fetchUser()
        let routineCategories = fetchCategoryListById(categoryIds: data.routineCategoryList)
        
        do{
            //  Set user skin type and sensitivity
            user.isSensitive = data.isSensitive!
            user.skinTypeId = data.selectedSkinType! as NSNumber
            
            //  Set problems as active
            problems.forEach { problem in
                problem.isActive = true
            }
            
            // Update routines
            var morningPosition: Int = 1
            var nightPosition: Int = 1
            routineCategories.forEach { category in
                if (category.isDay as! Bool){
                    createRoutineStep(category: category, isMorning: true, position: morningPosition)
                    morningPosition += 1
                }
                
                if (category.isNight as! Bool){
                    createRoutineStep(category: category, isMorning: false, position: nightPosition)
                    nightPosition += 1
                }
            }
            
            //  Create log with chosen image
            try context.save()
        }
        catch{
            print("update onboarding data failed")
        }
    }
    
    public func createRoutineStep(stepInfo: RoutineStepInfo, time: K.RoutineTime){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Steps", in: context)!
        
        let routineStep = StepModel(entity: entity, insertInto: context)

        routineStep.routineId = (time == .morning ? K.Routine.morning : K.Routine.night) as NSNumber
        routineStep.categoryId = fetchCategoryByTitle(title: stepInfo.title).id
        routineStep.position = stepInfo.position as NSNumber
        
        do{
            try context.save()
            print("Create routine step success")
            
        }
        catch{
            print("Create routine step failed")
        }
    }
    
    public func createRoutineStep(category: CategoryModel, isMorning: Bool, position: Int){
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

    public func fetchUser() -> UserModel {
        var user = UserModel()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do{
            let userResults:NSArray = try context.fetch(userRequest) as NSArray
            user = (userResults.firstObject as? UserModel)!
        }
        catch{
            print("fetch user failed")
        }
        
        return user
    }
    
    public func fetchUnaddedSteps(time: K.RoutineTime) -> [CategoryModel]{
        let allCategoryIds = [1,2,3,4,5,6,7,8,9]
        let allCategories = fetchCategoryListById(categoryIds: allCategoryIds)
        let addedSteps = fetchRoutineSteps(time: time)
        
        var unaddedSteps : [CategoryModel] = []
       
        allCategories.forEach { category in
            if addedSteps.first(where: {$0.title == category.title}) == nil{
                unaddedSteps.append(category)
            }
        }
        
        return unaddedSteps
    }
    
    public func deleteStep(step: RoutineStepInfo, time: K.RoutineTime){
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
    
    public func updateRoutine(steps: [RoutineStepInfo], time: K.RoutineTime){
        
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
    
    public func fetchRoutineSteps(time: K.RoutineTime) -> [RoutineStepInfo]{
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
                let currCat = fetchCategoryById(categoryId: Int(truncating: step.categoryId))
                stepInfoList.append(RoutineStepInfo(title: currCat.title!, position: Int(truncating: step.position)))
            }
        }
        catch{
            print("fetch failed")
        }
        return stepInfoList
    }
    
    public func fetchRoutines() -> [RoutineModel]{
            
        var routineList: [RoutineModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Routines")
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                let routine = result as? RoutineModel
                routineList.append(routine!)
            }
            
            return routineList
        }
        catch{
            print("fetch routines failed")
        }
        
        return routineList
    }
    
    public func fetchProblems(problemIds: [Int]) -> [ProblemModel]{
            
        var problemList: [ProblemModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Problems")
        
        var predicateList: [NSPredicate] = []
        problemIds.forEach { id in
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
    
    func fetchCategoryByTitle(title: String) -> CategoryModel{
        var category = CategoryModel()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        
        let idPredicate = NSPredicate(format: "title == %@", title)
        request.predicate = idPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            category = (results.firstObject) as! CategoryModel
        }
        catch{
            print("fetch failed")
        }
        
        return category
    }
    
    func fetchCategoryById(categoryId: Int) -> CategoryModel{
        var category = CategoryModel()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        
        let idPredicate = NSPredicate(format: "id == %@", String(describing: categoryId))
        request.predicate = idPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            category = (results.firstObject) as! CategoryModel
        }
        catch{
            print("fetch failed")
        }
        
        return category
    }
    
    func fetchCategoryListById(categoryIds: [Int]) -> [CategoryModel]{
            
        var categoryList: [CategoryModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        
        var predicateList: [NSPredicate] = []
        categoryIds.forEach { id in
            let idPredicate = NSPredicate(format: "id == %@", String(describing:id))
            predicateList.append(idPredicate)
        }
        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: predicateList)
        
        request.predicate = compoundPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            print(categoryIds)
            
            for result in results {
                let category = result as! CategoryModel
                categoryList.append(category)
            }
            
            categoryList.sort(by: {Int(truncating: $0.id) < Int(truncating: $1.id)})
        }
        catch{
            print("fetch failed")
        }
        
        return categoryList
    }
    
    func fetchIngredientListByEffect(effect: String) -> [IngredientModel]{
        var ingredientList: [IngredientModel] = []
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Ingredients")
        
        let effectPredicate = NSPredicate(format: "effects CONTAINS[c] %@", effect)
        
        request.predicate = effectPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                let ingredient = result as! IngredientModel
                ingredientList.append(ingredient)
            }
        }
        catch{
            print("fetch failed")
        }
        
        return ingredientList
    }
    
    func fetchEffectList(effectIds: [Int]) -> [EffectModel]{
            
        var effectList: [EffectModel] = []
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Effects")
        
        var predicateList: [NSPredicate] = []
        effectIds.forEach { id in
            let idPredicate = NSPredicate(format: "id == %@", String(describing:id))
            predicateList.append(idPredicate)
        }
        let compoundPredicate = NSCompoundPredicate(type: .or, subpredicates: predicateList)
        
        request.predicate = compoundPredicate
        
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
    
    public func fetchSkinType(id: Int) -> SkinTypeModel{
            
        var skinType: SkinTypeModel?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SkinTypes")
        let idPredicate = NSPredicate(format: "id == %@", String(describing:id+1))
        request.predicate = idPredicate
        
        do{
            let results:NSArray = try context.fetch(request) as NSArray
            
            for result in results {
                skinType  = result as? SkinTypeModel
            }
            
            return skinType!
        }
        catch{
            print("fetch failed")
        }
        
        return skinType!
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
