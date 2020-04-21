//
//  SelectedBrandCarsList.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/11/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import ReCaptcha

class SelectedBrandCarsList: UIViewController {
    
    lazy var indicator = UIActivityIndicatorView(style: .gray)
    
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
        tableView.separatorStyle = .none
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
        
        tableView.registerCell(BrandCell.self)
        configUI()
    }
}


extension SelectedBrandCarsList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(BrandCell.self, indexPath: indexPath)
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let carsVC = SelectedBrandCarsList()
//        navigationController?.pushViewController(carsVC, animated: true)
//    }
    
}

extension SelectedBrandCarsList{
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
