//
//  SelectedOfferHeaderView.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


class SelectedOfferHeaderView: UIView {
    
    fileprivate lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        return containerView
    }()
    
    fileprivate lazy var imgView:  UIImageView = {
        let img = UIImageView(frame: .zero)
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        img.image = UIImage(named: "Lexus.jpg")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    fileprivate lazy var line1 : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black
        return view
    }()
    
    
    fileprivate lazy var priceLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "7000000 тг"
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
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//       containerView.setCorners(corners: [.topLeft, .topRight], withRadius: 10.0)
//    }
}
//MARK: -ConfigUI
extension SelectedOfferHeaderView{
    func configUI() {
        
        addSubview(containerView)
        
        [priceLabel, imgView, line1].forEach {
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
        imgView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.left.equalToSuperview()
            m.right.equalToSuperview()
            m.height.equalTo(170)
        }
        priceLabel.snp.makeConstraints { (m) in
            m.top.equalTo(imgView.snp.bottom).offset(10)
            m.left.equalToSuperview().offset(16)
        }
        line1.snp.makeConstraints { (m) in
            m.top.equalTo(priceLabel.snp.bottom).offset(5)
            m.height.equalTo(1.0)
            m.width.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        
    }
}
