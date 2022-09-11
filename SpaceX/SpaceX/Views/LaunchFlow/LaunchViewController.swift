//
//  LaunchViewController.swift
//  SpaceX
//
//  Created by Эван Крошкин on 11.09.22.
//

import UIKit
import SnapKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        launchCollectionView.delegate = self
        launchCollectionView.dataSource = self
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
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchCollectionViewCell.identifier,
                                                      for: indexPath)
        if let cell = cell as? LaunchCollectionViewCell {
            cell.configureCell(nameRocketText: "Rocket",
                               dateLaunchText: "DAte",
                               statusLaunch: "ok")
        }
        return cell
    }
}
