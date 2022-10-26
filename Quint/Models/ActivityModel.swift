//
//  ActivityModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 26/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(ActivityModel)

class ActivityModel: NSManagedObject{
    @NSManaged var id: NSNumber
    @NSManaged var title: String?
    @NSManaged var desc: String?
    @NSManaged var icon: String?
}
