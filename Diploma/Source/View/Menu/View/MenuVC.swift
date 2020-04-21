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
    
    private let viewModel = MenuViewModel()
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
        makeRequests()
    }
}

//MARK: - Requests
extension MenuVC {
    func makeRequests() {
        let dg = DispatchGroup()
        
        dg.enter()
        getPacket(dg)
        
        dg.enter()
        getSocketRoom(dg)
        
        dg.notify(queue: .main) { [unowned self] in
            if Room.current != nil {
                SocketIOManager.sharedInstance.establishConnection()
            }
            self.tableView.reloadData()
        }
    }
    
    func getPacket(_ dg:DispatchGroup) {
        viewModel.getHealthcareClient({
            dg.leave()
        }) { (error) in
            dg.leave()
            self.alertError(text: error).subscribe().disposed(by: self.disposeBag)
        }
    }
    
    func getSocketRoom(_ dg:DispatchGroup) {
        viewModel.getSocketRoom({
            dg.leave()
        }) { (error) in
            dg.leave()
            self.alertError(text: error).subscribe().disposed(by: self.disposeBag)
        }
    }
}

//MARK: - Actions
extension MenuVC {
    fileprivate func handleTransition(_ viewController: UIViewController) {
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.changeMainViewController(viewController, close: true)
        }
    }
    
    func openVC(_ type:MenuType) {
        var vc = UIViewController()
        switch type {
        case .diagnostic:
            vc = ServiceListVC(type: .diagnostics)
        case .risks:
            vc = ServiceListVC(type: .questionnaire)
        case .settings:
            vc = ProfileVC()
        default:
            vc = ServiceListVC(type: .all)
        }
        vc.setMenuButton()
        vc.title = type.rawValue.localized
        let viewController = UINavigationController(rootViewController: vc)
        handleTransition(viewController)
        tableView.reloadData()
    }
}

//MARK: - UITableView
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isAdditional {
            return viewModel.fullMenuList.count
        }
        return viewModel.mainMenuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = isAdditional ? viewModel.fullMenuList[indexPath.row] : viewModel.mainMenuList[indexPath.row]
        
        switch menu.type {
        case .main, .card, .diagnostic, .addition, .risks:
            let cell = tableView.dequeueCell(MenuCell.self, indexPath: indexPath)
            cell._selected = selectedIndex == indexPath.row
            if menu.type == .addition {
                cell._selected = isAdditional
            }
            cell.menu = menu
            return cell
        default:
            let cell = tableView.dequeueCell(MenuSubCell.self, indexPath: indexPath)
            cell._selected = selectedIndex == indexPath.row
            cell.menu = menu
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.packet = Packet.current
        headerView.client = Client.current
        headerView.onSettingsClick = { [weak self] in
            guard let wSelf = self else { return }
            
            wSelf.openVC(.settings)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = isAdditional ? viewModel.fullMenuList[indexPath.row] : viewModel.mainMenuList[indexPath.row]
        selectedIndex = indexPath.row
        
        switch menu.type {
        case .addition:
            isAdditional.toggle()
            tableView.reloadData()
            tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
        case .main, .card, .diagnostic, .risks:
            isAdditional = false
            openVC(menu.type)
        default:
            openVC(menu.type)
        }
    }
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
