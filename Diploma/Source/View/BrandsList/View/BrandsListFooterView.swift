//
//  BrandsListFooterView.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit


class BrandsListFooterView: UIView {
    
    fileprivate lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        return containerView
    }()
    
    fileprivate lazy var line2 : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.fromRgb(rgb: 0xEBEBEB)
        return view
    }()
    
    fileprivate lazy var footerlabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Footer"
        lbl.font = UIFont(name: "Tahoma", size: 14)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.sizeToFit()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: -ConfigUI
extension BrandsListFooterView{
    func configUI() {
        
        addSubview(containerView)
        
        [line2, footerlabel].forEach {
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
            m.top.equalTo(line2.snp.bottom).offset(16)
            m.left.equalToSuperview().offset(16)
            m.right.equalToSuperview().offset(-10)
            m.bottom.equalToSuperview()
        }
    }
}
