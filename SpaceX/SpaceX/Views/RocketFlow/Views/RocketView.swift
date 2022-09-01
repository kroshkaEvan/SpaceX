//
//  RocketView.swift
//  SpaceX
//
//  Created by Эван Крошкин on 31.08.22.
//

import UIKit
import SnapKit

class RocketView: UIView {
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "SpaceX")
        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        view.layer.cornerRadius = 30
        return view
    }()
    
    lazy var rocketName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.text = "rocket name"
        label.font = .systemFont(ofSize: 24,
                                 weight: .bold)
        return label
    }()
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "gearshape"),
                                  for: UIControl.State.normal)
        button.tintColor = .white
        return button
    }()
    
    let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 96,
                                 height: 96)
        layout.minimumLineSpacing = 15
        return layout
    }()
    
    lazy var rocketCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .black
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 32,
                                                   bottom: 0, right: 32)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RocketCollectionViewCell.self,
                                forCellWithReuseIdentifier: RocketCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var rocketTableView: UITableView = {
        let tableView = UITableView(frame: .zero,
                                    style: .grouped)
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .black
        tableView.sectionHeaderHeight = 40
        tableView.register(RocketTableViewCell.self,
                           forCellReuseIdentifier: RocketTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRocketViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRocketViewLayout() {
        [backgroundImageView, contentView,
         rocketCollectionView, rocketTableView].forEach( {addSubview($0)} )
        [rocketName, settingsButton].forEach( {contentView.addSubview($0)} )
//        rocketTableView.bringSubviewToFront(self)
        
        backgroundImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(400)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(backgroundImageView.snp.bottom).offset(-20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        rocketName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.top.equalTo(backgroundImageView.snp.bottom).offset(20)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-32)
            make.centerY.equalTo(rocketName.snp.centerY)
            make.height.equalTo(45)
            make.width.equalTo(45)
        }
        
        rocketCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(rocketName.snp.bottom).offset(32)
            make.height.equalTo(96)
        }
        
        rocketTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.top.equalTo(rocketCollectionView.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
}
