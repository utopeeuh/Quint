//
//  RoutineModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 26/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(RoutineModel)

class RoutineModel: NSManagedObject{
    @NSManaged var id: NSNumber
    @NSManaged var title: String?
}
