//
//  ApiClient.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/9/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SVProgressHUD
import SystemConfiguration
import LocalAuthentication

typealias failure = (String?) -> Void

class ApiClient {
    static let shared = ApiClient()
    var authToken: String?
    
    func loadAsObservable<T:Codable> (_ route: ApiRouter, showLoad:Bool = true) -> Observable<T> {
        return Observable.create { [weak self] observer -> Disposable in
            guard let wSelf = self else { return Disposables.create() }
            
            if showLoad {
                SVProgressHUD.show()
                SVProgressHUD.setDefaultMaskType(.clear)
            }
            
            
            if wSelf.networkConnectionStatus == .notAvailable {
                let errorModel = ErrorModel(code: "", message: "", date: "")
                observer.onError(errorModel)
            }
            
            Alamofire.request(route)
                .validate()
                .responseJSON { response in
                    
                    if showLoad {
                        SVProgressHUD.dismiss()
                        SVProgressHUD.setDefaultMaskType(.clear)
                    }
                    
                    let headers = response.response?.allHeaderFields ?? [:]
                    if let authToken = headers["Authorization"] as? String {
                        self?.authToken = authToken
                    }
                    
                    switch response.result {
                    case .success:
                        
                        //----LOGGING----
                        wSelf.log(route, response)
                        
                        guard let data = response.data else {
                            observer.onError(response.error!)
                            return
                        }
                        do {
                            let object = try JSONDecoder().decode(T.self, from: data) 
//                            print(object?.results.count)
                            observer.onNext(object)
                        } catch {
                            observer.onError(error)
                        }
                        
                    case .failure(let errorFailure):
                        //----LOGGING----
                        wSelf.log(route, response)
                        
                        guard let data = response.data else {
                            observer.onError(response.error!)
                            return
                        }
                        do {
                            let error = try JSONDecoder().decode(ErrorModel.self, from: data)
                            observer.onError(error)
                        } catch {
                            observer.onError(errorFailure)
                        }
                        observer.onError(errorFailure)
                    }
            }
            return Disposables.create()
        }
    }
    
    func loadDecodable<T:Decodable>(_ route:ApiRouter, showLoad:Bool = true, _ success: @escaping (T?) -> Void, _ failure: @escaping (Error) -> Void) {
        if showLoad {
            SVProgressHUD.show()
        }
        
        guard networkConnectionStatus != .notAvailable else {
            let errorModel = ErrorModel(code: "", message: "", date: "")
            failure(errorModel)
            return
        }
        
        Alamofire.request(route)
            .responseJSON { [weak self] (response) in
                
                guard let wSelf = self else { return }
                
                if showLoad {
                    SVProgressHUD.dismiss()
                }
                
                if response.response?.statusCode == 200 && response.result.value == nil {
                    success(nil)
                    return
                }
                
                switch response.result {
                case .success:
                    //----LOGGING----
                    wSelf.log(route, response)
                    
                    guard let data = response.data else {
                        failure(response.error!)
                        return
                    }
                    
                    do {
                        let errorObject = try JSONDecoder().decode(ErrorModel.self, from: data)
                        failure(errorObject)
                        return
                    }catch{
                        do {
                            let object = try JSONDecoder().decode(T.self, from: data)
                            success(object)
                            return
                        }catch{
                            success(nil)
                            return
                        }
                    }
                case .failure:
                    //----LOGGING----
                    wSelf.log(route, response)
                    
                    guard let data = response.data else {
                        failure(response.error!)
                        return
                    }
                    
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        success(object)
                        return
                    }catch{
                        do {
                            let errorObject = try JSONDecoder().decode(ErrorModel.self, from: data)
                            failure(errorObject)
                            return
                        }catch{
                            failure(error)
                            return
                        }
                    }
                }
        }
    }
    
    func log(_ route:ApiRouter, _ response:DataResponse<Any>) {
        print("------------------START REQUEST---------------------------")
        print("-> URL REQUEST: ", route.urlRequest?.url?.absoluteString ?? "")
        print("-> API HEADERS: ", route.urlRequest?.allHTTPHeaderFields?.toData()?.prettyPrintedJSONString ?? "")
        print("-> METHOD: ", route.urlRequest?.httpMethod ?? "")
        if let body = route.urlRequest?.httpBody {
            print("-> API BODY: ", body.prettyPrintedJSONString ?? "")
        }
        print("<- STATUS CODE: ", response.response?.statusCode ?? "")
        
        if let urlResponseString = route.urlRequest?.url?.absoluteString {
            print("<- RESPONSE FROM URL: ", urlResponseString)
        }
        if let header = response.response?.allHeaderFields as? [String:Any] {
            print("<- RESPONSE HEADER: ", header.toData()?.prettyPrintedJSONString ?? "")
        }
        print("<- RESPONSE: ", response.data?.prettyPrintedJSONString ?? "")
        print("------------------END REQUEST---------------------------")
    }
    
    private enum NetworkConnectionStatus { case notAvailable, availableViaWWAN, availableViaWiFi }
    
    private var networkConnectionStatus: NetworkConnectionStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }
        guard let target = defaultRouteReachability else { return .notAvailable }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(target, &flags) { return .notAvailable }
        
        /* The target host is not reachable: */
        if !flags.contains(.reachable) { return .notAvailable }
            /* WWAN connections are OK if the calling application is using the CFNetwork APIs: */
        else if flags.contains(.isWWAN) { return .availableViaWWAN }
            /* If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi: */
        else if !flags.contains(.connectionRequired) { return .availableViaWiFi }
            /* The connection is on-demand (or on-traffic) if the calling application is
             using the CFSocketStream or higher APIs and no [user] intervention is needed: */
        else if (flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)) &&
            !flags.contains(.interventionRequired) { return .availableViaWiFi }
            /* else: */
        else { return .notAvailable }
    }
    
}

extension ApiClient {
    
//    var userLogin:BrandContainer? {
//        
//        set {
//            let encoder = JSONEncoder()
//            if let codePhone = newValue {
//                if let encoded = try? encoder.encode(codePhone) {
//                    let defaults = UserDefaults.standard
//                    defaults.set(encoded, forKey: Constants.kUserLogin)
//                }
//            }
//        }
//        
//        get {
//            let defaults = UserDefaults.standard
//            if let codePhone = defaults.object(forKey: Constants.kUserLogin) as? Data {
//                let decoder = JSONDecoder()
//                if let phone = try? decoder.decode(PhoneCode.self, from: codePhone) {
//                    return phone
//                }
//            }
//            return nil
//        }
//    }
    
    
    var client:String? {
        return KeychainService.load(service: Constants.service, key: Constants.client)
    }
    

    
    func setClient(_ client:String) {
        if KeychainService.load(service: Constants.service, key: Constants.client) != nil {
            KeychainService.remove(service: Constants.service, key: Constants.client)
            KeychainService.save(service: Constants.service, key: Constants.client, value: client)
        }else{
            KeychainService.save(service: Constants.service, key: Constants.client, value: client)
        }
    }
    
//    var notificationToken:String?

//    var chosenLanguage

}
