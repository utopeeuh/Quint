//
//  StepModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 26/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(StepModel)

class StepModel: NSManagedObject{
    @NSManaged var id: NSNumber
    @NSManaged var position: NSNumber
    @NSManaged var categoryId: NSNumber
}

