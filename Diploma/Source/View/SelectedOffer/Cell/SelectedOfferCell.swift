//
//  SelectedOfferCell.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/26/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

class SelectedOfferCell: UITableViewCell {
    
    fileprivate lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        return containerView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.text = "text"
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension SelectedOfferCell {
    func configUI() {
        selectionStyle = .none
        
        addSubview(containerView)
        
        [titleLabel, label].forEach {
            containerView.addSubview($0)
        }
        
        
        makeConstraints()
    }
    
    func makeConstraints() {
        
        containerView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.right.equalToSuperview().offset(-20)
            m.left.equalToSuperview().offset(20)
            m.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(16)
            m.left.equalToSuperview().offset(16)
        }
        label.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(16)
            m.right.equalToSuperview().offset(-16)
        }
        
    }
}

