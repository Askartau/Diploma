//
//  UIFont+Extension.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static let fontSize: CGFloat = 14

    static public func regular() -> UIFont {
        return self.regular(size: fontSize)
    }

    static public func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Tahoma", size: size)!
    }

    static public func bold() -> UIFont {
        return self.bold(size: fontSize)
    }
    
    static public func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Tahoma-Bold", size: size)!
    }

    static public func medium() -> UIFont {
        return self.medium(size: fontSize)
    }

    static public func medium(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

    static public func light() -> UIFont {
        return self.light(size: fontSize)
    }

    static public func light(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
}
