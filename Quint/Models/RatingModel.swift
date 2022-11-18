//
//  RatingModel.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 17/11/22.
//

import Foundation
import UIKit

class RatingModel {
    
    var productId: Int
    var thumbsUp: Int
    var thumbsDown: Int
    
    init(productId: Int) {
        self.productId = productId
        thumbsUp = 0
        thumbsDown = 0
    }
}
