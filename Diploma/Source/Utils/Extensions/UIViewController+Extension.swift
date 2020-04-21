//
//  UIViewController+Extension.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var safeAreaPadding:UIEdgeInsets {
        if #available(iOS 11.0, *) {
            if let safeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets {
                return safeAreaInsets
            }else{
                return UIEdgeInsets.zero
            }
        } else {
            return UIEdgeInsets.zero
        }
    }
}

extension UIViewController {
    public func setDissmissButton() {
        let menuImage = #imageLiteral(resourceName: "back_button").withRenderingMode(.alwaysTemplate)
        var menuItem = UIBarButtonItem()
        menuItem = UIBarButtonItem(image: menuImage,
                                   style: .plain,
                                   target: self,
                                   action: #selector(getBack))
        navigationItem.leftBarButtonItem = menuItem
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        view.isUserInteractionEnabled = true
        
        view.addGestureRecognizer(edgePan)
    }
    
    @objc func screenEdgeSwiped(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        getBack()
    }
    
    @objc fileprivate func getBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func openWithRootAnimatedVC(_ vc: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window {
            window.rootViewController = vc
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.4
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
                { completed in
            })
        }
    }
    
}
