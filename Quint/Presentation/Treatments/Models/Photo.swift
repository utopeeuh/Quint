//
//  Photo.swift
//  MVVMArchitecture
//
//  Created by Mohannad on 26.03.2021.
//

import UIKit

class Photo : Codable {
    var id : String
    var width : Int
    var height : Int
    var url : String
    var download_url : String
    
    init(_ id: String, _ size: Int, _ url: String, _ download_url: String) {
        self.id = id
        self.height = size
        self.width = size
        self.url = url
        self.download_url = download_url
    }
}
