//
//  Cars.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/23/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation

class CarsContainer: Codable {
    let results: [Cars]
}

class Cars: Codable {
    let name: String?
//    let manufactured_in: String?
//    let mark: String?
//    let image: URL
    
}
