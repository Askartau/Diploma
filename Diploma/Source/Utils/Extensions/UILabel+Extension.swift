//
//  UILabel+Extension.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func set(font:UIFont, textColor:UIColor) {
        self.font = font
        self.textColor = textColor
        self.numberOfLines = 0
    }
}
