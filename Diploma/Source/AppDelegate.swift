//
//  AppDelegate.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/9/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow( frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let nc = UINavigationController(rootViewController: BrandsListVC())
        window?.rootViewController = nc
        print("Screen width:", UIScreen.main.bounds.width)
        return true
    }
    

}

