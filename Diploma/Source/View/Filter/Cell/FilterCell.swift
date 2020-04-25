//
//  FilterCell.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

//
//  FilterCell.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

class FilterCell: UITableViewCell {
    
    
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
    
    fileprivate lazy var imgView:  UIImageView = {
        let img = UIImageView(frame: .zero)
        img.clipsToBounds = true
        img.image = UIImage(named: "arrow.jpg")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension FilterCell {
    func configUI() {
        selectionStyle = .none
        
        addSubview(containerView)
        
        [titleLabel, imgView].forEach {
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
        imgView.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(16)
            m.right.equalToSuperview().offset(-10)
            m.width.equalTo(20)
            m.height.equalTo(20)
        }
        
    }
}

