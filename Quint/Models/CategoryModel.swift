//
//  CategoryModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 27/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(CategoryModel)

class CategoryModel: NSManagedObject{
    @NSManaged var id: NSNumber
    @NSManaged var title: String?
}
