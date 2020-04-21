//
//  KeychainService.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/7/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import Security

let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

public class KeychainService: NSObject {
    
    class func update(service: String, key:String, value: String) {
        if let dataFromString: Data = value.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue])
            
            let status = SecItemUpdate(keychainQuery as CFDictionary, [kSecValueDataValue:dataFromString] as CFDictionary)
            
            if (status != errSecSuccess) {
                if #available(iOS 11.3, *) {
                    if let err = SecCopyErrorMessageString(status, nil) {
                        print("Read failed: \(err)")
                    }
                } else {
                }
            }
        }
    }
    
    
    class func remove(service: String, key:String) {
        
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key, kCFBooleanTrue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue])
        
        let status = SecItemDelete(keychainQuery as CFDictionary)
        if (status != errSecSuccess) {
            if #available(iOS 11.3, *) {
                if let err = SecCopyErrorMessageString(status, nil) {
                    print("Remove failed: \(err)")
                }
            } else {
            }
        }
        
    }
    
    
    class func save(service: String, key:String, value: String) {
        if let dataFromString = value.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
            
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
            
            if (status != errSecSuccess) {
                if #available(iOS 11.3, *) {
                    if let err = SecCopyErrorMessageString(status, nil) {
                        print("Write failed: \(err)")
                    }
                } else {
                }
            }
        }
    }
    
    class func load(service: String, key:String) -> String? {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, key, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String?
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
    
}
