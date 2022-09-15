//
//  LaunchViewController.swift
//  SpaceX
//
//  Created by Эван Крошкин on 11.09.22.
//

import UIKit
import SnapKit

protocol LaunchViewProtocol: AnyObject {
    func successUpload()
    func successNil()
    func failure(error: NetworkError)
}

class LaunchViewController: UIViewController {
    
    private lazy var widthCollectionView = view.frame.size.width - 64
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: widthCollectionView,
                                 height: 100)
        layout.minimumLineSpacing = 16
        return layout
    }()
    
    private lazy var launchCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(LaunchCollectionViewCell.self,
                                forCellWithReuseIdentifier: LaunchCollectionViewCell.identifier)
        return collectionView
    }()
    
    var presenter: LaunchPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionView()
        configureNavigation()
    }
    
    private func setupCollectionView() {
        launchCollectionView.delegate = self
        launchCollectionView.dataSource = self
    }
    
    private func configureNavigation() {
        navigationController?.isNavigationBarHidden = false
        title = presenter?.rocketName
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setupLayout() {
        view.backgroundColor = .black
        view.addSubview(launchCollectionView)
        
        launchCollectionView.snp.makeConstraints { make in
            make.width.equalTo(widthCollectionView)
            make.top.equalToSuperview().offset(128)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension LaunchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.launches?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCollectionViewCell.identifier,
                                                      for: indexPath)
        if let cell = cell as? LaunchCollectionViewCell {
            presenter?.getLaunchesDataToCell(indexPath: indexPath.row,
                                             complition: { name, dateLocal, statusLaunch in
                cell.configureCell(nameRocketText: name ?? "",
                                   dateLaunchText: dateLocal ?? "",
                                   statusLaunch: statusLaunch ?? "")
            })
        }
        return cell
    }
}

extension LaunchViewController: LaunchViewProtocol {
    func successUpload() {
        launchCollectionView.reloadData()
    }
    
    func successNil() {
        print("launch nil")
    }
    
    func failure(error: NetworkError) {
        print(error)
    }
    
    
}
