//
//  TipsRepository.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 06/11/22.
//

import Foundation
import UIKit
import CoreData

protocol TipsRepositoryDelegate{
    func fetchRandomTip() -> String
}

class TipsRepository: TipsRepositoryDelegate{
    
    static let shared = TipsRepository()
    
    func fetchRandomTip() -> String{
        
        var text = ""
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tips")
        
        do{
            let results: [TipModel] = try context.fetch(request) as! [TipModel]
            
            text = results.randomElement()?.desc ?? ""
        }
        catch{
            print("fetch failed")
        }
        
        return text
    }
}
