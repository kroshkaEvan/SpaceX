//
//  LaunchCollectionViewCell.swift
//  SpaceX
//
//  Created by Эван Крошкин on 11.09.22.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {
    static let identifier = "LaunchCollectionViewCell"
    
    // MARK: - Private properties
    
    private lazy var nameRocketLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 20,
                                 weight: .semibold)
        return label
    }()
    
    private lazy var dateLaunchLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16,
                                 weight: .light)
        return label
    }()
    
    private lazy var statusLaunchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ok")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupCellLayout() {
        contentView.layer.backgroundColor = UIColor(red: 33/255,
                                                    green: 33/255,
                                                    blue: 33/255,
                                                    alpha: 1).cgColor
        contentView.layer.cornerRadius = 24
        contentView.layer.masksToBounds = true
        [nameRocketLabel, dateLaunchLabel, statusLaunchImageView].forEach( {addSubview($0)} )
        
        nameRocketLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(28)
        })
        
        dateLaunchLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
            make.top.equalTo(nameRocketLabel.snp.bottom)
            make.height.equalTo(24)
        })
        
        statusLaunchImageView.snp.makeConstraints({ make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
        })
    }
    
    func configureCell(nameRocketText: String,
                       dateLaunchText: String,
                       statusLaunch: String) {
        nameRocketLabel.text = nameRocketText
        dateLaunchLabel.text = dateLaunchText
        statusLaunchImageView.image = UIImage(named: statusLaunch)
    }
}
