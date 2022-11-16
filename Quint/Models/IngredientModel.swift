//
//  IngredientModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 25/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(IngredientModel)

class IngredientModel: NSManagedObject{
    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var alt: String
    @NSManaged var desc: String
    @NSManaged var effects: String
    @NSManaged var avoidIfSens : Bool
    @NSManaged var goodNormal: NSNumber
    @NSManaged var goodDry: NSNumber
    @NSManaged var goodCombination: NSNumber
    @NSManaged var goodOily: NSNumber
    @NSManaged var allergen: String
    @NSManaged var usage: String
    @NSManaged var source: String
}
