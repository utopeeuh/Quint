//
//  RatingCoreModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 17/11/22.
//

import Foundation
import UIKit
import CoreData

@objc(RatingCoreModel)

class RatingCoreModel: NSManagedObject{
    @NSManaged var productId: NSNumber
    @NSManaged var rated: NSNumber
}
