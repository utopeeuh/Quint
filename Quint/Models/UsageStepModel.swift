//
//  UsageStepModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 27/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(UsageStepModel)

class UsageStepModel: NSManagedObject{
    @NSManaged var id: NSNumber
    @NSManaged var categoryId: NSNumber
    @NSManaged var title: String?
    @NSManaged var desc: String?
}
