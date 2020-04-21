//
//  UIView+Extension.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var safeAreaPadding:UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
        } else {
            return UIEdgeInsets.zero
        }
    }
}

extension UIView {
    func setCorners(corners:UIRectCorner, withRadius:CGFloat){
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds,
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: withRadius, height: withRadius)).cgPath
        self.layer.mask = rectShape
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 6
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}
