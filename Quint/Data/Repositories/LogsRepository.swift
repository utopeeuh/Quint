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
    func checkIfLogExists(date: Date)
}

class LogRepository: LogRepositoryDelegate{
    
    static let shared = LogRepository()
    
    func checkIfLogExists(date: Date) {
        
    }
    
    func setRoutineAsDone(time: K.RoutineTime){
        
    }
}
