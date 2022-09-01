//
//  ViewController.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import UIKit
import SnapKit

class RocketViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.contentInsetAdjustmentBehavior = .never
        view.showsVerticalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()
    
    private var descriptionRocketView = RocketView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionAndTableView()
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
    
    private func setupCollectionAndTableView() {
        descriptionRocketView.collectionView.dataSource = self
        descriptionRocketView.collectionView.delegate = self
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
            cell.valueLabel.text = "3223"
            cell.parameterLabel.text = "Mass"
        }
        return cell
    }
}
