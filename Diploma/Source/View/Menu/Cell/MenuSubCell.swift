//
//  MenuSubCell.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/11/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

class MenuSubCell: UITableViewCell {
    
    
    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.set(font: UIFont.regular(size: 16), textColor: UIColor.blueMain)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Methods
extension MenuSubCell {
}

//MARK: - ConfigUI
extension MenuSubCell {
    func configUI() {
        selectionStyle = .none
        
        addSubview(titleLabel)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(20)
            m.left.equalToSuperview().offset(80)
            m.right.equalToSuperview().offset(-16)
            m.bottom.equalToSuperview().offset(-20)
        }
    }
}

