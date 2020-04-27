//
//  BrandsListVC.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 2/10/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa


class BrandsListVC: UIViewController {
    
    private let viewModel = BrandsListViewModel()
    private let disposeBag = DisposeBag()
    
    
    fileprivate var headerView = BrandsListHeaderView()
    fileprivate var footerView = BrandsListFooterView()
    
    var brandContainer: BrandContainer?{
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var searchController: UISearchController = {
        let s = UISearchController(searchResultsController: nil)
        
        s.obscuresBackgroundDuringPresentation = false
        s.searchBar.placeholder = "Поиск марок"
        s.searchBar.sizeToFit()
        s.searchBar.searchBarStyle = .prominent

        return s
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedSectionHeaderHeight = 320
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.registerCell(BrandsListCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "CarBase"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        configUI()
        getBrandslist()
    }
    
}
//MARK: - Requests
extension BrandsListVC {
    func getBrandslist() {
        viewModel.getBrandsList({ result in
            self.brandContainer = result
            
        }) { (error) in
            self.alertError(text: error).subscribe().disposed(by: self.disposeBag)
        }
    }
}


//MARK: - Binding Views
extension BrandsListVC {
    func setObservers() {
        
//        tableView.rx.modelSelected(BrandsList.self)
//        changePassword.rx.tap.subscribe(onNext: { [weak self] in
//            guard let wSelf = self else { return }
//            wSelf.openChangePasswordVC()
//
//        }).disposed(by: disposeBag)
        
        
    }
}

//extension BrandsListVC: UISearchBarDelegate {
//
//}


extension BrandsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brandContainer?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(BrandsListCell.self, indexPath: indexPath)
        cell.brands = brandContainer?.results[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedBrandCarsList = SelectedBrandCarsListVC()
        navigationController?.pushViewController(selectedBrandCarsList, animated: true)
    }
    
}


//MARK: - ConfigUI
extension BrandsListVC{
    func configUI() {
        
        view.addSubview(tableView)
        makeConstraints()
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { (m) in
            m.top.equalToSuperview().offset(100)
            m.left.right.equalToSuperview()
            m.bottom.equalToSuperview().offset(-48-self.safeAreaPadding.bottom)
        }
    }
}

