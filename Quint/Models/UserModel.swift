//
//  UserModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 24/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(UserModel)

class UserModel: NSManagedObject{
    @NSManaged var skinTypeId: NSNumber
    @NSManaged var isSensitive: Bool
    @NSManaged var problemIds: [NSNumber]
}
