//
//  MenuCell.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/11/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

class MenuCell: UITableViewCell {
    
    
    fileprivate lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.mainColor
        return imageView
    }()
    
    fileprivate lazy var iconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8.0
        return view
    }()
    
    
    fileprivate lazy var iconContainerShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8.0
        return view
    }()
    
     var titleLabel: UILabel = {
        let label = UILabel()
        label.set(font: UIFont.regular(size: 16), textColor: UIColor.mainColor)
        return label
    }()
    
    fileprivate var rightArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.set(image: #imageLiteral(resourceName: "down_purple_arrow"))
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconContainerShadowView.dropShadow()
    }
}

//MARK: - Methods
extension MenuCell {
}

//MARK: - ConfigUI
extension MenuCell {
    func configUI() {
        selectionStyle = .none
        
        [iconContainerShadowView, iconContainerView, titleLabel].forEach {
            addSubview($0)
        }
        
        addSubview(iconImageView)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        iconContainerView.snp.makeConstraints { (m) in
            m.left.equalToSuperview().offset(16)
            m.top.equalToSuperview().offset(8)
            m.width.height.equalTo(48)
            m.bottom.equalToSuperview().offset(-8)
        }
        
        iconContainerShadowView.snp.makeConstraints { (m) in
            m.edges.equalTo(iconContainerView)
        }
        
        titleLabel.snp.makeConstraints { (m) in
            m.left.equalTo(iconContainerView.snp.right).offset(16)
            m.centerY.equalTo(iconContainerView)
            m.right.equalToSuperview().offset(-16)
        }
        
        iconImageView.snp.makeConstraints { (m) in
            m.center.equalTo(iconContainerView)
            m.width.height.equalTo(20)
        }
    }
    
    func setRightArrow() {
        addSubview(rightArrow)
        
        titleLabel.snp.remakeConstraints { (m) in
            m.left.equalTo(iconContainerView.snp.right).offset(16)
            m.centerY.equalTo(iconContainerView)
        }
        
        rightArrow.snp.makeConstraints { (m) in
            m.left.equalTo(titleLabel.snp.right).offset(16)
            m.centerY.equalTo(titleLabel)
            m.width.height.equalTo(10)
        }
        
        layoutIfNeeded()
    }
}

