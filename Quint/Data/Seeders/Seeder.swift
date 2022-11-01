//
//  Seeder.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

class Seeder: SeederDelegate{
    
    var json: JSON!
    var fileName: String!
    
    required init() {}
    
    func seed(){}
    func seedFromJson(){
        
        if let path = Bundle.main.path(forResource: self.fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                json = try JSON(data: data)
            } catch let error {
                print("parse error: \(error)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
        seed()
    }
}
