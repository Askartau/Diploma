//
//  SelectedOfferVC.swift
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


class SelectedOfferVC: UIViewController {
    
    open var onApplyClick:(() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    let offerFields = OfferFields.getAllOfferFields()
    
    fileprivate var headerView = SelectedOfferHeaderView()
    fileprivate var footerView = SelectedOfferFooterView()
    
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
        tableView.registerCell(SelectedOfferCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "CarBase"
        configUI()
    }
    
}
//MARK: - Requests
//extension SelectedOfferVC {
//    func getBrandslist() {
//        viewModel.getBrandsList({ result in
//            self.brandContainer = result
//
//        }) { (error) in
//            self.alertError(text: error).subscribe().disposed(by: self.disposeBag)
//        }
//    }
//}

struct OfferFields {
    let title: String
    
    static func getAllOfferFields() -> [OfferFields] {
        return [
            OfferFields(title: "city".localized),
            OfferFields(title: "mark".localized),
            OfferFields(title: "model".localized),
            OfferFields(title: "gear".localized),
            OfferFields(title: "car_body".localized),
            OfferFields(title: "gear_box".localized)
        ]
    }
}

//MARK: - Actions
extension SelectedOfferVC {

    func openApplicationVC(){
        let vc = ApplicationVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension SelectedOfferVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueCell(SelectedOfferCell.self, indexPath: indexPath)
        cell.titleLabel.text = offerFields[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        return headerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footerView.onApplyClick = { [weak self] in
            guard let wSelf = self else {return}
            
            wSelf.openApplicationVC()
        }
        return footerView
    }
    
    
}


//MARK: - ConfigUI
extension SelectedOfferVC{
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

