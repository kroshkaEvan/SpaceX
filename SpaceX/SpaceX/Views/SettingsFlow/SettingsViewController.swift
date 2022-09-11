//
//  SettingsViewController.swift
//  SpaceX
//
//  Created by Эван Крошкин on 11.09.22.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .black
        tableView.register(SettingsTableViewCell.self,
                           forCellReuseIdentifier: SettingsTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationController()
        setupTableView()
    }
    
    private func setupNavigationController() {
        let closeButton = UIBarButtonItem(title: "Close",
                                          style: .plain,
                                          target: self,
                                          action: #selector(didTapClose))
        closeButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = closeButton
    }
    
    
    private func setupTableView() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    private func setupLayout() {
        view.addSubview(settingsTableView)
        
        settingsTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(112)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func didTapClose() {
        
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier,
                                                 for: indexPath)
        if let cell = cell as? SettingsTableViewCell {
            switch indexPath.section {
            case 0:
                cell.configureCell(parameterText: "Height",
                                   segmentedItems: ["m", "ft"])
            case 1:
                cell.configureCell(parameterText: "Diameter",
                                   segmentedItems: ["m", "ft"])
            case 2:
                cell.configureCell(parameterText: "Mass",
                                   segmentedItems: ["kg", "lb"])
            case 3:
                cell.configureCell(parameterText: "Payload weight",
                                   segmentedItems: ["kg", "lb"])
            default:
                cell.configureCell(parameterText: "Mass",
                                   segmentedItems: ["kg", "lb"])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
