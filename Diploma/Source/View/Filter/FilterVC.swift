//
//  FilterVC.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReCaptcha

class FilterVC: UIViewController {
    
    private let viewModel = SelectedBrandViewModel()
    private let disposeBag = DisposeBag()
    
    let filterFields = FilterFields.getAllFilterFields()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        //        tableView.estimatedRowHeight = 64
        //        tableView.rowHeight = UITableView.automaticDimension
        //
        //        tableView.estimatedSectionHeaderHeight = 320
        //        tableView.sectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.registerCell(FilterCell.self)
        configUI()
    }
}

struct FilterFields {
    let title: String
    
    static func getAllFilterFields() -> [FilterFields] {
        return [
            FilterFields(title: "city".localized),
            FilterFields(title: "mark".localized),
            FilterFields(title: "model".localized),
            FilterFields(title: "gear".localized),
            FilterFields(title: "car_body".localized),
            FilterFields(title: "gear_box".localized)
        ]
    }
}


extension FilterVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(FilterCell.self, indexPath: indexPath)
        cell.titleLabel.text = filterFields[indexPath.row].title
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let offerByBrand = OffersByBrandVC()
//        navigationController?.pushViewController(offerByBrand, animated: true)
//    }
    
}

extension FilterVC{
    func configUI() {
        
        view.addSubview(tableView)
        makeConstraints()
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
}
