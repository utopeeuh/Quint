//
//  ProductModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 26/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(ProductModel)

class ProductModel: NSManagedObject{
    @NSManaged var id: NSNumber
    @NSManaged var categoryId: NSNumber
    @NSManaged var brand: String
    @NSManaged var name: String
    @NSManaged var price: String
    @NSManaged var url: String
    @NSManaged var image: String
    @NSManaged var ingredients: String
    @NSManaged var matchingIngredients: NSNumber
    @NSManaged var isRecommended: Bool
}
