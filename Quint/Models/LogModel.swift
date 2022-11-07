//
//  LogModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 26/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(LogModel)

class LogModel: NSManagedObject{
    @NSManaged var moodId: NSNumber
    @NSManaged var isLogDone: Bool
    @NSManaged var isDayDone: Bool
    @NSManaged var isNightDone: Bool
    @NSManaged var date: Date
    @NSManaged var sleep: NSNumber
    @NSManaged var activityLevel: NSNumber
    @NSManaged var isBetter: Bool
    @NSManaged var imagePath: String?
}
