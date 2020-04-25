//
//  OffersByBrandCell.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class OffersByBrandCell: UITableViewCell {
    
    
    
    lazy var indicator = UIActivityIndicatorView(style: .gray)
    
    fileprivate lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        //        containerView.layer.cornerRadius = 10
        containerView.layer.borderColor = UIColor.mainColor.cgColor
        containerView.layer.shadowColor = UIColor.gray.cgColor
        //        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = .zero
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
    
    let txtLabel: UILabel = {
        let txt = UILabel(frame: .zero)
        txt.font = UIFont.regular(size: 12)
        txt.text = "Lexus"
        return txt
    }()
    
    let costLabel: UILabel = {
        let cost = UILabel(frame: .zero)
        cost.font = UIFont.regular(size: 12)
        cost.text = "$$$$"
        return cost
    }()
    
    fileprivate lazy var typeLabel: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont.regular(size: 34)
        lbl.text = "RX350"
        return lbl
    }()
    
    fileprivate lazy var line1 : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.autoBgGray
        return view
    }()
    
    //    fileprivate lazy var detailsButton : UIButton = {
    //        let detailsButton = UIButton(frame: .zero)
    //        detailsButton.backgroundColor = UIColor.white
    //        detailsButton.setTitle("Подробнее", for: .normal)
    //        detailsButton.setTitleColor(UIColor.blueMain, for: .normal)
    //        //detailsButton.addTarget(self, action: #selector(openPackageDetailsVC), for: .touchUpInside)
    //        return detailsButton
    //    }()
    //
    //    fileprivate lazy var buyButton: OurButton = {
    //        let button = OurButton(type: .filled)
    //        button.title = "Выбрать"
    //        return button
    //    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - ConfigUI
extension OffersByBrandCell{
    func configUI() {
        
        backgroundColor = .white
        selectionStyle = .none
        
        addSubview(containerView)
        
        [imgView, txtLabel, costLabel, typeLabel, line1].forEach {
            containerView.addSubview($0)
        }
        imgView.addSubview(indicator)
        makeConstraints()
    }
    
    func makeConstraints() {
        
        containerView.snp.makeConstraints { (m) in
            //            m.top.equalToSuperview().offset(10)
            //            m.right.equalToSuperview().offset(-20)
            //            m.left.equalToSuperview().offset(20)
            //            m.bottom.equalToSuperview()
            m.edges.equalToSuperview()
        }
        
        imgView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.left.equalToSuperview()
            m.right.equalToSuperview()
            m.height.equalTo(170)
        }
        indicator.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
        }
        txtLabel.snp.makeConstraints{(m) in
            m.top.equalTo(imgView.snp.bottom).offset(10)
            m.left.equalTo(imgView).offset(16)
        }
        costLabel.snp.makeConstraints{(m) in
            m.top.equalTo(imgView.snp.bottom).offset(10)
            m.right.equalTo(imgView).offset(-16)
        }
        typeLabel.snp.makeConstraints{(m) in
            m.top.equalTo(txtLabel.snp.bottom).offset(10)
            m.left.equalTo(txtLabel)
        }
        line1.snp.makeConstraints { (m) in
            m.top.equalTo(typeLabel.snp.bottom).offset(24)
            m.width.equalTo(imgView)
            m.height.equalTo(1.0)
            m.centerX.equalToSuperview()
            m.bottom.equalToSuperview().offset(-10)
        }
        
        //        detailsButton.snp.makeConstraints { (m) in
        //            m.top.equalTo(line1.snp.bottom).offset(10)
        //            m.centerX.equalToSuperview()
        //        }
        //        buyButton.snp.makeConstraints { (m) in
        //            m.top.equalTo(detailsButton.snp.bottom).offset(20)
        //            m.centerX.equalToSuperview()
        //            m.width.equalTo(216)
        //            m.height.equalTo(50)
        //            m.bottom.equalToSuperview().offset(-10)
        //        }
    }
}
