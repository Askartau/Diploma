//
//  UIColor+Extension.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static let mainColor = #colorLiteral(red: 0.005771268625, green: 0.7737252116, blue: 0.671456337, alpha: 1)
    static let bgLightGray = UIColor.fromRgb(rgb: 0xC4C4C4)
    static let bgGray = UIColor.fromRgb(rgb: 0xDFE0E9)
    static let greenMain = UIColor.fromRgb(rgb: 0x00BFA8)
    static let textLightGray = UIColor.fromRgb(rgb: 0x909AAA)
    
    static let autoBlue = UIColor.fromRgb(rgb: 0x5644FB)
    static let autoPink = UIColor.fromRgb(rgb: 0xD0827D)
    static let autoGreen = UIColor.fromRgb(rgb: 0x51B4C1)
    static let autoPurple = UIColor.fromRgb(rgb: 0xAC83F3)
    static let autoLightBlue = UIColor.fromRgb(rgb: 0x8193E3)
    static let autoDarkBlue = UIColor.fromRgb(rgb: 0x5E59D3)
    static let autoBgGray = UIColor.fromRgb(rgb: 0xE5E5E5)
    
    static func fromRgb(rgb:Int, alpha: CGFloat = 1.0) -> UIColor{
        return UIColor(red: (CGFloat((rgb&0xFF0000) >> 16))/255.0, green: (CGFloat((rgb&0xFF00) >> 8))/255.0, blue: (CGFloat(rgb&0xFF))/255.0, alpha: alpha)
    }
}
