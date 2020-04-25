//
//  OurButton.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/11/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

enum OurButtonType{
    case empty
    case filled
    case bordered
}

class OurButton: UIButton {
    var type:OurButtonType!
    
    public var title : String = "" {
        didSet {
            if self.type == .empty || self.type == .bordered {
                setAttributedTitle(NSAttributedString(string: title.uppercased(), attributes:
                    [
                        NSAttributedString.Key.font : UIFont.regular(size: 14),
                        NSAttributedString.Key.foregroundColor : UIColor.mainColor
                    ]), for: .normal)
            } else {
                setAttributedTitle(NSAttributedString(string: title.uppercased(), attributes:
                    [
                        NSAttributedString.Key.font : UIFont.regular(size: 14),
                        NSAttributedString.Key.foregroundColor : UIColor.white
                    ]), for: .normal)
            }
        }
    }
    
    public var bgColor : UIColor = UIColor.mainColor {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    init(type:OurButtonType) {
        super.init(frame: .zero)
        
        self.type = type
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Methods
extension OurButton {
    func setDisabled(_ disabled:Bool = true) {
        isUserInteractionEnabled = !disabled
        backgroundColor = disabled ? UIColor.mainColor.withAlphaComponent(0.3) : UIColor.mainColor
    }
}


// MARK: - ConfigUI
extension OurButton {
    func configUI() {
        
        layer.masksToBounds = true
        layer.cornerRadius = 8.0
        
        if type == .empty {
            backgroundColor = .clear
        } else if self.type == .bordered {
            backgroundColor = .clear
            layer.borderColor = UIColor.mainColor.cgColor
            layer.borderWidth = 1.0
        } else {
            backgroundColor = .mainColor
        }
    }
}
