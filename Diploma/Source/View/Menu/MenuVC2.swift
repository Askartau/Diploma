//
//  MenuVC.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/11/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SocketIO

class MenuVC: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var selectedIndex = 0
    
    private var isAdditional:Bool = false
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(MenuCell.self)
        tableView.registerCell(MenuSubCell.self)
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedSectionHeaderHeight = 120
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    fileprivate var headerView = MenuHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
}

//MARK: - Requests

//MARK: - Actions


//MARK: - UITableView
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(MenuCell.self, indexPath: indexPath)
        cell.titleLabel.text = "Screen \(indexPath.row+1)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
}

//MARK: - ConfigUI
extension MenuVC {
    func configUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(UIApplication.shared.statusBarFrame.height)
            m.left.right.bottom.equalToSuperview()
        }
    }
}
