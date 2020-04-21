//
//  Error+Extension.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/7/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation

enum ErrorType:String {
    case SESSION_NOT_FOUND = "SESSION_NOT_FOUND"
    case TOKEN_EXPIRED = "TOKEN_EXPIRED"
    case SESSION_EXPIRED = "SESSION_EXPIRED"
    case REGISTERED = "REGISTERED"
    case UNAUTHORIZED = "UNAUTHORIZED"
    case OPERATION_NOT_CONFIRMED = "OPERATION_NOT_CONFIRMED"
}


extension Error {
    func handleError() -> String? {
        if let err = self as? ErrorModel {
            if err.code == ErrorType.SESSION_NOT_FOUND.rawValue || err.code == ErrorType.OPERATION_NOT_CONFIRMED.rawValue || err.code == ErrorType.REGISTERED.rawValue || err.code == ErrorType.TOKEN_EXPIRED.rawValue || err.code == ErrorType.SESSION_EXPIRED.rawValue || err.code == ErrorType.UNAUTHORIZED.rawValue  {
                return err.code
            }else{
                return err.message
            }
        }else{
            return self.localizedDescription
        }
    }
}
