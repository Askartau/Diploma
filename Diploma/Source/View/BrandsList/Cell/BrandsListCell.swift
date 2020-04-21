//
//  BrandsListCell.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

class BrandsListCell: UITableViewCell {
    
        var brands: [BrandsList]? {
            didSet {
                guard let brands = brands else { return }
                for brand in brands {
                if let name = brand.name {
                    titleLabel.text = name
                }
                }
            }
        }

    
    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension BrandsListCell {
    func configUI() {
        selectionStyle = .none
        
        addSubview(containerView)
        
        [titleLabel].forEach {
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
            m.right.equalToSuperview().offset(-16)
        }
        
    }
}

