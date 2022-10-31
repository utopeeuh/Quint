//
//  String+LetterCase.swift
//  Quint
//
//  Created by Tb. Daffa Amadeo Zhafrana on 31/10/22.
//

import Foundation
extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
