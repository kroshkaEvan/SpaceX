//
//  ViewController.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import UIKit
import SnapKit

protocol RocketViewProtocol: AnyObject {
    func successUpload()
    func failure(error: NetworkError)
    func successSaveUserDefaults()
    func isShowLoadingView(_ isShow: Bool)
}

class RocketViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var descriptionRocketView: RocketView? {
        guard isViewLoaded else { return nil }
        return view as? RocketView
    }
    
    private lazy var loadingView = LoadingView()
    
    // MARK: - Public properties
    
    var presenter: RocketPresenterProtocol?
    let networkManager = NetworkManager()
    var serialNumber: Int
    
    // MARK: - Lifecycle

    init(serialNumber: Int) {
        self.serialNumber = serialNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupView()
        setupActions()
        successUpload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigation()
        reloadView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.updateView()
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        view = RocketView()
        view.backgroundColor = .black
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    private func setupView() {
        descriptionRocketView?.rocketCollectionView.dataSource = self
        descriptionRocketView?.rocketCollectionView.delegate = self
        descriptionRocketView?.rocketTableView.dataSource = self
        descriptionRocketView?.rocketTableView.delegate = self
    }
    
    private func setupActions() {
        descriptionRocketView?.watchRocketLaunchesButton.addTarget(self,
                                                                   action: #selector(didTapLaunches),
                                                                   for: .touchUpInside)
        descriptionRocketView?.settingsButton.addTarget(self,
                                                        action: #selector(didTapSettings),
                                                        for: .touchUpInside)
    }
    
    private func reloadView() {
        descriptionRocketView?.rocketCollectionView.reloadData()
        descriptionRocketView?.rocketTableView.reloadData()
    }
}

// MARK: - Objc Methods

extension RocketViewController {
    @objc private func didTapLaunches()  {
        presenter?.openLaunchVC(serialNumber: serialNumber)
    }
    
    @objc private func didTapSettings()  {
        presenter?.openSettingsVC()
    }
}

// MARK: - RocketViewProtocol

extension RocketViewController: RocketViewProtocol {
    func successSaveUserDefaults() {
        DispatchQueue.main.async { [weak self] in
            self?.reloadView()
        }
    }
    
    func successUpload() {
        descriptionRocketView?.rocketName.text = presenter?.rockets?[serialNumber].name
        presenter?.fetchRocketImage(descriptionRocketView?.backgroundImageView ?? UIImageView(),
                                    with: serialNumber)
    }
    
    func failure(error: NetworkError) {
        let message = "\(error.localizedDescription) \nRestart"
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: (restart))
        let alertLogOut = UIAlertController(title: "Oops!",
                                            message: message,
                                            preferredStyle: .alert)
        alertLogOut.addAction(action)
        present(alertLogOut, animated: true)
        print(error)
    }
    
    func restart(action: UIAlertAction) {
        presenter?.fetchRockets()
    }
    
    func isShowLoadingView(_ isShow: Bool) {
        if isShow == true {
            loadingView.isHidden = false
        } else if isShow == false {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1),
                                          execute: { () -> Void in
                self.loadingView.isHidden = true
            })
        }
    }
}

// MARK: - UICollectionViewDataSource

extension RocketViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketCollectionViewCell.identifier,
                                                      for: indexPath)
        if let cell = cell as? RocketCollectionViewCell,
           let rocket = presenter?.rockets?[serialNumber] {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch indexPath.row {
                case 0:
                    if self.presenter?.userDefaults.height == 0 {
                        cell.configureCell(parameterText: "Height, m",
                                           valueText: "\(rocket.height.meters ?? 0)")
                    } else {
                        cell.configureCell(parameterText: "Height, ft",
                                           valueText: "\(rocket.height.feet ?? 0)")
                    }
                case 1:
                    if self.presenter?.userDefaults.diameter == 0 {
                        cell.configureCell(parameterText: "Diameter, m",
                                           valueText: "\(rocket.diameter.meters ?? 0)")
                    } else {
                        cell.configureCell(parameterText: "Diameter, ft",
                                           valueText: "\(rocket.diameter.feet ?? 0)")
                    }
                case 2:
                    if self.presenter?.userDefaults.mass == 0 {
                        cell.configureCell(parameterText: "Mass, kg",
                                           valueText: "\(rocket.mass.kg)")
                    } else {
                        cell.configureCell(parameterText: "Mass, lb",
                                           valueText: "\(rocket.mass.lb)")
                    }
                case 3:
                    if self.presenter?.userDefaults.payload == 0 {
                        cell.configureCell(parameterText: "Payload, kg",
                                           valueText: "\(rocket.payloadWeights.first?.kg ?? 0)")
                    } else {
                        cell.configureCell(parameterText: "Payload, lb",
                                           valueText: "\(rocket.payloadWeights.first?.lb ?? 0)")
                    }
                default:
                    cell.configureCell(parameterText: "",
                                       valueText: "")
                }
            }
        }
        return cell
    }
}

// MARK: - UITableViewDataSource

extension RocketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: tableView.frame.size.width,
                                              height: 40))
        let label = UILabel()
        label.frame = CGRect(x: 0,
                             y: 0,
                             width: headerView.frame.size.width,
                             height: headerView.frame.size.height)
        label.font = .systemFont(ofSize: 16,
                                 weight: .semibold)
        label.textColor = .white
        
        switch section {
        case 0:
            label.text = ""
        case 1:
            label.text = "FIRST STAGE"
        case 2:
            label.text = "SECOND STAGE"
        default:
            label.text = ""
        }
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RocketTableViewCell.identifier,
                                                 for: indexPath)
        if let cell = cell as? RocketTableViewCell,
           let rocket = presenter?.rockets?[serialNumber] {
            DispatchQueue.main.async {
                switch indexPath.section {
                case 0:
                    switch indexPath.row {
                    case 0:
                        cell.configureCell(parameterText: "First launch",
                                           valueText: "\(rocket.firstFlight)")
                    case 1:
                        cell.configureCell(parameterText: "Country",
                                           valueText: "\(rocket.country)")
                    case 2:
                        cell.configureCell(parameterText: "Coast launch",
                                           valueText: "\(rocket.costPerLaunch) $")
                    default:
                        cell.configureCell(parameterText: "",
                                           valueText: "")
                    }
                case 1:
                    switch indexPath.row {
                    case 0:
                        cell.configureCell(parameterText: "Number of engines",
                                           valueText: "\(rocket.firstStage.engines)")
                    case 1:
                        cell.configureCell(parameterText: "Fuel amount",
                                           valueText: "\(rocket.firstStage.fuelAmountTons) ton")
                    case 2:
                        cell.configureCell(parameterText: "Burn time",
                                           valueText: "\(rocket.firstStage.burnTimeSEC ?? 0) sec")
                    default:
                        cell.configureCell(parameterText: "",
                                           valueText: "")
                    }
                case 2:
                    switch indexPath.row {
                    case 0:
                        cell.configureCell(parameterText: "Number of engines",
                                           valueText: "\(rocket.secondStage.engines)")
                    case 1:
                        cell.configureCell(parameterText: "Fuel amount",
                                           valueText: "\(rocket.secondStage.fuelAmountTons) ton")
                    case 2:
                        cell.configureCell(parameterText: "Burn time",
                                           valueText: "\(rocket.secondStage.burnTimeSEC ?? 0) sec")
                    default:
                        cell.configureCell(parameterText: "",
                                           valueText: "")
                    }
                default:
                    cell.configureCell(parameterText: "",
                                       valueText: "")
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
}
