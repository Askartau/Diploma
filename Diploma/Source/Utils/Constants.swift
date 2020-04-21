//
//  Constants.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/4/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let service = "CarBase"
    static let client = "client"
    static let language = "language"
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

    static let fieldOffset = UIScreen.main.bounds.width*0.26
    static let spacing = Constants.screenHeight*0.0375


    //The API's URLs
    static let testUrl = "http://127.0.0.1:8000/"
    
    //The header fields
    enum HttpHeaderField: String {
        case authorization = "Authorization"
        case acceptType = "Accept"
        case contentType = "Content-Type"
        case acceptLanguage = "Accept-Language"
        case brand = "brand"
        case portal = "portal"
        case test = "test"
        case requester = "requester"
        case client = "client"
        case session = "session"
        
        case device_uid = "device-uid"
        case device_model = "device-model"
        case device_os = "device-os"
        case device_os_version = "device-os-version"
        case app_version = "app-version"
        case device_push_token = "device-push-token"
        case captcha_token = "captcha-token"
        
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
        case portal = "ios"
    }
    
    enum ActionType: String {
        case ADD_CONTACT = "ADD_CONTACT"
    }
    
    
    enum StatementType: String {
        case none = "none"
        case fixed = "fixed"
        case range = "range"
    }
    
    enum CellType:String {
        case POINT_INFO_TOP = "POINT_INFO_TOP"
        case POINT_INFO_MIDDLE = "POINT_INFO_MIDDLE"
        case POINT_INFO_BOTTOM = "POINT_INFO_BOTTOM"
        case NEWS_DETAIL_CELL = "NEWS_DETAIL_CELL"
    }
    
    enum NotificationType:String {
        case DIAGNOSTICS_READY = "DIAGNOSTICS_READY"
    }
    
    static func url() -> String{
        #if DEVELOPMENT
        return testUrl
        #elseif PREPROD
        return testUrl
        #else
        return testUrl
        #endif
    }
    
    
    
    static func deviceModel() -> String {
        return UIDevice.modelName
    }
    
    static func deviceOS() -> String {
        return UIDevice.current.systemName
    }
    
    static func deviceOsVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    static func appVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        
        return ""
    }
}
