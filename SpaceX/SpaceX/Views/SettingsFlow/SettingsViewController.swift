//
//  SettingsViewController.swift
//  SpaceX
//
//  Created by Эван Крошкин on 11.09.22.
//

import UIKit
import SnapKit

protocol SettingsViewProtocol: AnyObject {
    func didTapClose()
    func massSegmentDidChange(_ sender: UISegmentedControl)
    func heightSegmentDidChange(_ sender: UISegmentedControl)
    func payloadSegmentDidChange(_ sender: UISegmentedControl)
    func diameterSegmentDidChange(_ sender: UISegmentedControl)
}

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
    
    var presenter: SettingsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureNavigation()
        setupTableView()
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.topItem?.title = "Настройки"
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
}

extension SettingsViewController: SettingsViewProtocol {
    @objc internal func didTapClose() {
        presenter?.closeVC()
    }
    
    @objc internal func massSegmentDidChange(_ sender: UISegmentedControl) {
        presenter?.userDefaults.mass = sender.selectedSegmentIndex
    }
    
    @objc internal func heightSegmentDidChange(_ sender: UISegmentedControl) {
        presenter?.userDefaults.height = sender.selectedSegmentIndex
    }
    
    @objc internal func payloadSegmentDidChange(_ sender: UISegmentedControl) {
        presenter?.userDefaults.payload = sender.selectedSegmentIndex
    }
    
    @objc internal func diameterSegmentDidChange(_ sender: UISegmentedControl) {
        presenter?.userDefaults.diameter = sender.selectedSegmentIndex
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
                cell.valueSegmentedControl.addTarget(nil,
                                                     action: #selector(heightSegmentDidChange(_: )),
                                                     for: .valueChanged)
                cell.configureCell(parameterText: "Height",
                                   segmentedItems: ["m", "ft"])
                cell.valueSegmentedControl.selectedSegmentIndex = presenter?.userDefaults.height ?? 0
            case 1:
                cell.valueSegmentedControl.addTarget(nil,
                                                     action: #selector(diameterSegmentDidChange(_:)),
                                                     for: .valueChanged)
                cell.configureCell(parameterText: "Diameter",
                                   segmentedItems: ["m", "ft"])
                cell.valueSegmentedControl.selectedSegmentIndex = presenter?.userDefaults.diameter ?? 0
            case 2:
                cell.valueSegmentedControl.addTarget(nil,
                                                     action: #selector(massSegmentDidChange(_: )),
                                                     for: .valueChanged)
                cell.configureCell(parameterText: "Mass",
                                   segmentedItems: ["kg", "lb"])
                cell.valueSegmentedControl.selectedSegmentIndex = presenter?.userDefaults.mass ?? 0
            case 3:
                cell.valueSegmentedControl.addTarget(nil,
                                                     action: #selector(payloadSegmentDidChange(_:)),
                                                     for: .valueChanged)
                cell.configureCell(parameterText: "Payload weight",
                                   segmentedItems: ["kg", "lb"])
                cell.valueSegmentedControl.selectedSegmentIndex = presenter?.userDefaults.payload ?? 0
            default:
                print("")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
