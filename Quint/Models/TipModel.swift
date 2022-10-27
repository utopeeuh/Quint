//
//  TipModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 27/10/22.
//

import Foundation
import UIKit
import CoreData

@objc(TipModel)

class TipModel: NSManagedObject{
    @NSManaged var id: NSNumber
    @NSManaged var desc: String?
}

