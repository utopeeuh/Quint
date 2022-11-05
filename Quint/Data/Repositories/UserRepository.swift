//
//  UserRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol UserRepositoryDelegate{
    func fetchUser() -> UserModel
}

class UserRepository: UserRepositoryDelegate{
    
    static let shared = UserRepository()
    
    func fetchUser() -> UserModel {
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
}
