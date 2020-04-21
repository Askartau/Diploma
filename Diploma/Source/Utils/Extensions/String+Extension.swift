//
//  String+Extension.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/7/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        if let lang = UserDefaults.standard.value(forKey: Constants.language) as? String, let bundlePath = Bundle.main.path(forResource: lang, ofType: "lproj"), let bundle = Bundle(path: bundlePath) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
        }else{
            if let bundlePath = Bundle.main.path(forResource: LanguageType.ru.rawValue, ofType: "lproj"), let bundle = Bundle(path:bundlePath) {
                return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
            }
            return NSLocalizedString(self, comment: "")
        }
    }
}

extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}

extension String {
    var textWithoutPhoneMask: String {
        if self.count == 0 {
            return self
        }
        
        var result = self
        
        // remove country code 8 or +7
        if result[result.startIndex] == "8" {
            result.remove(at: result.startIndex)
        }
        result = result.replacingOccurrences(of: "+7", with: "")
        
        // remove special characters
        result = result.replacingOccurrences(of: " ", with: "")
        result = result.replacingOccurrences(of: "(", with: "")
        result = result.replacingOccurrences(of: ")", with: "")
        result = result.replacingOccurrences(of: "-", with: "")
        
        var cleanResult = ""
        for c in result {
            if CharacterSet.decimalDigits.contains(String(c).unicodeScalars.first!) {
                cleanResult += String(c)
            }
        }
        
        return cleanResult
    }
    
    var roundedDouble:String {
        if let rateAvg = Double(self) {
            let rateRounded = Double(round(100*rateAvg)/100)
            if floor(rateRounded) == rateRounded {
                return String(Int(rateRounded))
            }
            return String(rateRounded)
        }
        
        return self
    }
}

// MARK Passwords rules
extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[!@#$%^&]).{8,14}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    var isValidPswNumber: Bool {
        let passwordRegEx = ".*[0-9]+.*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    var isValidPswLetter: Bool {
        return isUpperCaseLetter && isSmallLetter
    }
    
    var isUpperCaseLetter: Bool {
        let passwordRegEx = ".*[A-Z]+.*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    var isSmallLetter: Bool {
        let passwordRegEx = ".*[a-z]+.*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    var isValidPswSimbol: Bool {
        let passwordRegEx = ".*[!@#$%^&]+.*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    var isValidPswMinSimbol: Bool {
        let passwordRegEx = ".{8,14}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
}
