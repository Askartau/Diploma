//
//  BrandsListHeaderView.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class BrandsListHeaderView: UIView {
    
    fileprivate lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        return containerView
    }()
    
//    fileprivate lazy var searchButton: OurButton = {
//        let button = OurButton(type: .bordered)
//        button.title = "Найти"
//        return button
//    }()
//    
//    fileprivate lazy var line1 : UIView = {
//        let view = UIView(frame: .zero)
//        view.backgroundColor = UIColor.autoBgGray
//        return view
//    }()
    
    
    fileprivate lazy var carLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Марки:"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
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
        
        containerView.setCorners(corners: [.topLeft, .topRight], withRadius: 10.0)
    }
}
//MARK: -ConfigUI
extension BrandsListHeaderView{
    func configUI() {
        
        addSubview(containerView)
        
        [carLabel].forEach {
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

        carLabel.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(20)
            m.centerX.equalToSuperview()
            m.bottom.equalToSuperview()
        }
    }
}
