//
//  ApplicationVC.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit

class ApplicationVC: UIViewController {
    
    fileprivate lazy var nameField: OurTextField = {
        let textField = OurTextField()
//        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.placeholder = "name".localized
        return textField
    }()
    fileprivate lazy var surnameField: OurTextField = {
        let textField = OurTextField()
        textField.placeholder = "surname".localized
        return textField
    }()
    fileprivate lazy var phoneField: OurTextField = {
        let textField = OurTextField()
        textField.placeholder = "phone_number".localized
        return textField
    }()
    fileprivate lazy var mailField: OurTextField = {
        let textField = OurTextField()
        textField.placeholder = "mail".localized
        return textField
    }()
    
    fileprivate lazy var requestCallButton: OurButton = {
        let button = OurButton(type: .filled)
        button.title = "request_a_call".localized
        return button
    }()
    
    fileprivate lazy var callButton: OurButton = {
        let button = OurButton(type: .filled)
        button.title = "call_yourself".localized
        return button
    }()
    
    fileprivate lazy var requestCallLabel: UILabel = {
        let label = UILabel()
        label.text = "Закажите звонок, и менеджер автосалона с вами свяжется"
        label.font = UIFont.regular(size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.sizeToFit()
        return label
    }()
    
    fileprivate lazy var callLabel: UILabel = {
        let label = UILabel()
        label.text = "Или можете сами связаться по указонному номеру"
        label.font = UIFont.regular(size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.sizeToFit()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }

    
}

//MARK: - ConfigUI
extension  ApplicationVC{
    func configUI() {
        view.backgroundColor = .white
        
        [nameField, surnameField, phoneField, mailField, requestCallLabel, requestCallButton, callLabel, callButton].forEach {
            view.addSubview($0)
        }
        
        makeConstraints()
    }
    
    func makeConstraints() {
        _ = Constants.screenHeight*0.0375
        _ = Constants.screenWidth*0.1
        
        nameField.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.width.equalToSuperview().offset(-Constants.fieldOffset)
            m.top.equalToSuperview().offset(100)
        }
        surnameField.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.width.equalToSuperview().offset(-Constants.fieldOffset)
            m.top.equalTo(nameField.snp.bottom).offset(Constants.screenHeight*0.05)
        }
        phoneField.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.width.equalToSuperview().offset(-Constants.fieldOffset)
            m.top.equalTo(surnameField.snp.bottom).offset(Constants.screenHeight*0.05)
        }
        mailField.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.width.equalToSuperview().offset(-Constants.fieldOffset)
            m.top.equalTo(phoneField.snp.bottom).offset(Constants.screenHeight*0.05)
        }
        requestCallLabel.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.width.equalToSuperview().offset(-Constants.fieldOffset)
            m.top.equalTo(mailField.snp.bottom).offset(10)
        }
        requestCallButton.snp.makeConstraints { (m) in
            m.top.equalTo(requestCallLabel.snp.bottom).offset(Constants.screenHeight*0.05)
            m.centerX.equalToSuperview()
            m.width.equalTo(290)
            m.height.equalTo(56)
        }
        callLabel.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.width.equalToSuperview().offset(-Constants.fieldOffset)
            m.top.equalTo(requestCallButton.snp.bottom).offset(Constants.screenHeight*0.05)
        }
        callButton.snp.makeConstraints { (m) in
            m.top.equalTo(callLabel.snp.bottom).offset(Constants.screenHeight*0.05)
            m.centerX.equalToSuperview()
            m.width.equalTo(290)
            m.height.equalTo(56)
        //    m.bottom.equalToSuperview().offset(-20)
        }
        
    }
}
