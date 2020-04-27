//
//  Offers.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation

class OffersContainer: Codable {
    let results: [Offers]
}

class Offers: Codable {
    let price: Int?
    
    //    let manufactured_in: String?
    //    let mark: String?
    //    let image: URL
    
}
