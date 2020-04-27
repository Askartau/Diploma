//
//  SelectedOfferFooterView.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit


class SelectedOfferFooterView: UIView {
    
    open var onApplyClick:(() -> Void)?
    
    
    fileprivate lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        return containerView
    }()
    
    fileprivate lazy var line2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    fileprivate lazy var footerlabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "apply_text".localized
        lbl.textAlignment = .center
        lbl.set(font: UIFont.regular(size: 16), textColor: UIColor.gray)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.sizeToFit()
        return lbl
    }()
    
    fileprivate lazy var applyButton: OurButton = {
        let button = OurButton(type: .filled)
        button.title = "apply".localized
        button.addTarget(self, action: #selector(openApplicationVC), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: Action
extension SelectedOfferFooterView{
    
    @objc func openApplicationVC() {
        if onApplyClick != nil {
            onApplyClick!()
        }
    }
}
//MARK: -ConfigUI
extension SelectedOfferFooterView{
    func configUI() {
        
        addSubview(containerView)
        
        [line2,footerlabel, applyButton].forEach {
            containerView.addSubview($0)
        }
        
        makeConstraints()
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.right.equalToSuperview()
            m.left.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        line2.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(15)
            m.width.equalToSuperview()
            m.height.equalTo(1.0)
        }
        footerlabel.snp.makeConstraints { (m) in
            m.top.equalTo(line2.snp.bottom).offset(20)
            m.centerX.equalToSuperview()
            m.width.equalToSuperview().offset(-Constants.fieldOffset)
        }
        applyButton.snp.makeConstraints { (m) in
          //  m.top.equalTo(footerlabel.snp.bottom).offset(16)
            m.centerX.equalToSuperview()
            m.width.equalTo(290)
            m.height.equalTo(56)
            m.bottom.equalToSuperview().offset(-10)
        }
    }
}
