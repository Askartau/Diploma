//
//  ApiRouter.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/9/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import Alamofire


enum ApiRouter : URLRequestConvertible {

    
    //MARK: BrandsList
    case getBrandsList
    
    //MARK: ------HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getBrandsList:
            return .get
            
        }
    }
    
    //MARK: ------Path
    private var path: String {
        switch self {
            //MARK: BrandsList
        case .getBrandsList:
            return "marks/"
        }
        
    }
    
    
    //MARK: ------Parameters
    private var parameters: [String:Any]? {
        switch self {
            
        
            
        default:
            return [:]
        }
    }
    //MARK: ------URLRequest
    func asURLRequest() throws -> URLRequest {
        
        let url = try (Constants.url()).asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        
        #if DEVELOPMENT
        urlRequest.setValue("false", forHTTPHeaderField: Constants.HttpHeaderField.test.rawValue)
        #elseif PREPROD
        urlRequest.setValue("true", forHTTPHeaderField: Constants.HttpHeaderField.test.rawValue)
        #else
        urlRequest.setValue("false", forHTTPHeaderField: Constants.HttpHeaderField.test.rawValue)
        #endif
        
        
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .patch, .delete:
                return URLEncoding.default
            default:
                return URLEncoding.httpBody
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    
}
