//
//  ErrorModel.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/7/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation

struct ErrorModel:Error, Codable {
    var code: String
    var message: String
    var date: String
}
