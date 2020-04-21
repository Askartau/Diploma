//
//  UIAlertViewController+Rx.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/7/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

extension UIViewController{
    func alert(title: String, text: String?) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "close".localized, style: .default, handler: {_ in
                observer.onCompleted()
            }))
            self?.present(alertVC, animated: true, completion: nil)
            return Disposables.create {
            }
        }
    }
    
    func alertError(text: String?) -> Observable<Void> {
        
        if text == ErrorType.SESSION_NOT_FOUND.rawValue || text == ErrorType.SESSION_EXPIRED.rawValue || text == ErrorType.TOKEN_EXPIRED.rawValue {
            return Observable.create { [weak self] observer in
                //self?.present(SessionExpiredVC(), animated: true, completion: nil)
                return Disposables.create {
                    
                }
            }
        }else{
            return Observable.create { [weak self] observer in
                let alertVC = UIAlertController(title: "error".localized, message: text, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "close".localized, style: .default, handler: {_ in
                    observer.onCompleted()
                }))
                self?.present(alertVC, animated: true, completion: nil)
                return Disposables.create {
                    
                }
            }
        }
    }
    
    func alertError(text: String?, _ completion: (() -> Void)? = nil) -> Observable<Void> {
        
        if text == ErrorType.SESSION_NOT_FOUND.rawValue || text == ErrorType.SESSION_EXPIRED.rawValue || text == ErrorType.TOKEN_EXPIRED.rawValue {
            return Observable.create { [weak self] observer in
                //self?.present(SessionExpiredVC(), animated: true, completion: nil)
                return Disposables.create {
                    
                }
            }
        }else{
            return Observable.create { [weak self] observer in
                let alertVC = UIAlertController(title: "error".localized, message: text, preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "close".localized, style: .default, handler: {_ in
                    if let completion = completion {
                        completion()
                    }
                    observer.onCompleted()
                }))
                self?.present(alertVC, animated: true, completion: nil)
                return Disposables.create {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func alert(_ title: String, _ message: String, _ completion: (() -> Void)? = nil) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "close".localized, style: .default, handler: {_ in
                if let completion = completion {
                    completion()
                }
                observer.onCompleted()
            }))
            self?.present(alertVC, animated: true, completion: nil)
            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
