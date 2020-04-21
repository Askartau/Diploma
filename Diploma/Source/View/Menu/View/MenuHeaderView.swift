//
//  MenuHeaderView.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/11/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

class MenuHeaderView: UIView {
    
    
    open var onSettingsClick:(() -> Void)?
    
    
    fileprivate var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.set(image: #imageLiteral(resourceName: "logo_title"))
        return imageView
    }()
    
    fileprivate var nameLabel: UILabel = {
        let label = UILabel()
        label.set(font: UIFont.regular(size: 16), textColor: .black)
        return label
    }()
    
    fileprivate var phoneLabel: UILabel = {
        let label = UILabel()
        label.set(font: UIFont.regular(size: 12), textColor: UIColor.textLightGray)
        return label
    }()
    
    fileprivate var freeLabel: UILabel = {
        let label = UILabel()
        label.set(font: UIFont.regular(size: 10), textColor: .white)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var freeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.greenMain
        return view
    }()
    
    fileprivate lazy var languageButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "down_arrow_dark"), for: .normal)
        button.addTarget(self, action: #selector(languageClicked), for: .touchUpInside)
        button.semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        return button
    }()
    
    fileprivate lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "exit_icn"), for: .normal)
        button.addTarget(self, action: #selector(exitClicked), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "settings_icn"), for: .normal)
        button.addTarget(self, action: #selector(settingsClicked), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        freeContainerView.setCorners(corners: [.topLeft, .bottomRight], withRadius: 30)
    }
}

//MARK: - Actions
extension MenuHeaderView {
    @objc func languageClicked() {
        
    }
    
    @objc func exitClicked() {
        
    }
    
    @objc func settingsClicked() {
        if onSettingsClick != nil {
            onSettingsClick!()
        }
    }
}

//MARK: - ConfigUI
extension MenuHeaderView {
    func configUI() {
        
        backgroundColor = .white
        
        [logoImageView, nameLabel, phoneLabel, freeContainerView, languageButton, exitButton, settingsButton].forEach {
            addSubview($0)
        }
        
        freeContainerView.addSubview(freeLabel)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        logoImageView.snp.makeConstraints { (m) in
            m.left.top.equalToSuperview().offset(24)
            m.width.equalTo(136)
            m.height.equalTo(40)
        }
        
        languageButton.snp.makeConstraints { (m) in
            m.right.equalToSuperview().offset(-24)
            m.centerY.equalTo(logoImageView)
            m.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints { (m) in
            m.top.equalTo(logoImageView.snp.bottom).offset(16)
            m.left.right.equalTo(logoImageView)
            m.height.equalTo(24)
        }
        
        phoneLabel.snp.makeConstraints { (m) in
            m.top.equalTo(nameLabel.snp.bottom).offset(5)
            m.height.equalTo(16)
            m.left.right.equalTo(nameLabel)
        }
        
        freeContainerView.snp.makeConstraints { (m) in
            m.left.equalTo(phoneLabel)
            m.top.equalTo(phoneLabel.snp.bottom).offset(11)
            m.height.equalTo(24)
            m.width.equalTo(74)
            m.bottom.equalToSuperview().offset(-20)
        }
        
        exitButton.snp.makeConstraints { (m) in
            m.top.equalTo(languageButton.snp.bottom).offset(24)
            m.right.equalTo(languageButton)
            m.width.height.equalTo(20)
        }
        
        settingsButton.snp.makeConstraints { (m) in
            m.top.equalTo(exitButton.snp.bottom).offset(40)
            m.width.height.equalTo(20)
            m.right.equalTo(exitButton)
        }
        
        freeLabel.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
        }
    }
}
