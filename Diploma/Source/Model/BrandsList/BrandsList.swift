//
//  BrandsList.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/6/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation

class BrandContainer: Codable {
    let results: [BrandsList]
}

class BrandsList: Codable {
    let name: String?
    let id: Int?
//    var image: URL
    
}
