//
//  UIAppliaction+Extension.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/11/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication{
    var topViewController: UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            topController = checkForTop(vc: topController)
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                if let vc = getTop(vc: topController) {
                    topController = vc
                }
            }
            return topController
        }
        return keyWindow?.rootViewController
    }
    
    var topWindow: UIViewController?{
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                if let vc = getTop(vc: topController) {
                    topController = vc
                }
            }
            return topController
        }
        return keyWindow?.rootViewController
    }
    
    fileprivate func checkForTop(vc: UIViewController) -> UIViewController {
        var topContoller: UIViewController? = vc
        while (topContoller as? UINavigationController) != nil ||
            (topContoller as? UITabBarController) != nil  ||
            //            (topContoller as? UIPageViewController) != nil ||
            topContoller == nil
        {
            if let newTop = getTop(vc: topContoller!) {
                topContoller = newTop
            } else {
                break
            }
        }
        return topContoller == nil ? vc : topContoller!
    }
    
    fileprivate func getTop(vc: UIViewController) -> UIViewController? {
        var topController: UIViewController?
        switch vc {
        case let navigationController as UINavigationController:
            if let last = navigationController.viewControllers.last {
                topController = last
            }
        case let tabBarController as UITabBarController:
            if let selected = tabBarController.selectedViewController {
                topController = selected
            }
            
        default:
            break
        }
        return topController
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let statusBar = UIView()
            UIApplication.shared.keyWindow?.addSubview(statusBar)
            return statusBar
        } else if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        } else {
            return nil
        }
        
    }
}

