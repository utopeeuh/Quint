//
//  MoodModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 04/11/22.
//

import Foundation
import UIKit
import CoreData

@objc(MoodModel)

class MoodModel: NSManagedObject{
    @NSManaged var id: NSNumber
    @NSManaged var title: String?
}
