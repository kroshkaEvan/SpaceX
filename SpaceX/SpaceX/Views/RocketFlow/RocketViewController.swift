//
//  ViewController.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import UIKit
import SnapKit

protocol RocketViewProtocol: AnyObject {
    func success()
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
    
    var presenter: RocketPresenter?
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
        setupCollectionAndTableView()
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
    
    private func setupCollectionAndTableView() {
        descriptionRocketView.rocketCollectionView.dataSource = self
        descriptionRocketView.rocketCollectionView.delegate = self
        descriptionRocketView.rocketTableView.dataSource = self
        descriptionRocketView.rocketTableView.delegate = self
    }
}

extension RocketViewController: RocketViewProtocol {
    func success() {
        
    }
    
    func failure(error: NetworkError) {
        
    }
    

}

extension RocketViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RocketCollectionViewCell.identifier,
                                                      for: indexPath)
        if let cell = cell as? RocketCollectionViewCell {
            cell.configureCell(parameterText: "Mass",
                               valueText: "322000")
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
            label.text = "ПЕРВАЯ СТУПЕНЬ"
        case 2:
            label.text = "ВТОРАЯ СТУПЕНЬ"
        default:
            label.text = nil
        }
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RocketTableViewCell.identifier,
                                                 for: indexPath)
        if let cell = cell as? RocketTableViewCell {
            
            switch indexPath.section {
                
            case 0:
                switch indexPath.row {
                case 0:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                case 1:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                case 2:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                default:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                }
                
            case 1:
                switch indexPath.row {
                case 0:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                case 1:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                case 2:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                default:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                }
                
            case 2:
                switch indexPath.row {
                case 0:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                case 1:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                case 2:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                default:
                    cell.configureCell(parameterText: "Mass",
                                       valueText: "322000")
                }
            default:
                cell.configureCell(parameterText: "Mass",
                                   valueText: "322000")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
