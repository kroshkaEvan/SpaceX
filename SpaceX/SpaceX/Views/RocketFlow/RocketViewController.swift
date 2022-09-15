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
}

class RocketViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.contentInsetAdjustmentBehavior = .never
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
    
    private var descriptionRocketView = RocketView()
    
    var presenter: RocketPresenterProtocol?
    let networkManager = NetworkManager()
    var serialNumber: Int
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigation()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionRocketView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        descriptionRocketView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(1280)
        }
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    private func setupView() {
        descriptionRocketView.rocketCollectionView.dataSource = self
        descriptionRocketView.rocketCollectionView.delegate = self
        descriptionRocketView.rocketTableView.dataSource = self
        descriptionRocketView.rocketTableView.delegate = self
    }
    
    private func setupActions() {
        descriptionRocketView.watchRocketLaunchesButton.addTarget(self,
                                                                  action: #selector(didTapLaunches),
                                                                  for: .touchUpInside)
        descriptionRocketView.settingsButton.addTarget(self,
                                                       action: #selector(didTapSettings),
                                                       for: .touchUpInside)
    }
}

extension RocketViewController {
    @objc private func didTapLaunches()  {
        presenter?.openLaunchVC(serialNumber: serialNumber)
    }
    
    @objc private func didTapSettings()  {
        presenter?.openSettingsVC()
    }
}

extension RocketViewController: RocketViewProtocol {
    func successUpload() {
        descriptionRocketView.rocketName.text = presenter?.rockets?[serialNumber].name
        presenter?.fetchRocketImage(descriptionRocketView.backgroundImageView,
                                    with: serialNumber)
        descriptionRocketView.rocketCollectionView.reloadData()
        descriptionRocketView.rocketTableView.reloadData()
    }
    
    func failure(error: NetworkError) {
        print(error)
    }

}

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
            DispatchQueue.main.async {
                switch indexPath.row {
                case 0:
                    cell.configureCell(parameterText: "Height, m",
                                       valueText: "\(rocket.height.meters ?? 0)")
                case 1:
                    cell.configureCell(parameterText: "Diameter, m",
                                       valueText: "\(rocket.diameter.meters ?? 0)")
                case 2:
                    cell.configureCell(parameterText: "Mass, kg",
                                       valueText: "\(rocket.mass.kg)")
                case 3:
                    cell.configureCell(parameterText: "Payload, kg",
                                       valueText: "\(rocket.payloadWeights.first?.kg ?? 0)")
                default:
                    cell.configureCell(parameterText: "",
                                       valueText: "")
                }
            }
        }
        return cell
    }
}

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
                                              width: tableView.frame.width,
                                              height: 40))
        let label = UILabel()
        label.frame = CGRect(x: 0,
                             y: 0,
                             width: headerView.frame.width,
                             height: headerView.frame.height)
        label.font = .systemFont(ofSize: 16,
                                 weight: .semibold)
        label.textColor = .white
        
        switch section {
        case 0:
            label.text = nil
        case 1:
            label.text = "FIRST STAGE"
        case 2:
            label.text = "SECOND STAGE"
        default:
            label.text = nil
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
}
