//
//  RocketCollectionViewCell.swift
//  SpaceX
//
//  Created by Эван Крошкин on 31.08.22.
//

import UIKit
import SnapKit

class RocketCollectionViewCell: UICollectionViewCell {
    static let identifier = "RocketCollectionViewCell"
    
    // MARK: - Public properties
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16,
                                 weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var parameterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14,
                                 weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueLabel, parameterLabel])
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCellLayout() {
        contentView.layer.backgroundColor = UIColor(red: 33/255,
                                                    green: 33/255,
                                                    blue: 33/255,
                                                    alpha: 1).cgColor
        contentView.layer.cornerRadius = 32
        contentView.layer.masksToBounds = true
        [stackView].forEach( {addSubview($0)} )
        
        stackView.snp.makeConstraints({ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        
        parameterLabel.snp.makeConstraints({ make in
            make.height.equalTo(20)
        })
        
        valueLabel.snp.makeConstraints({ make in
            make.height.equalTo(20)
        })
    }
    
    func configureCell(parameterText: String,
                       valueText: String) {
        parameterLabel.text = parameterText
        valueLabel.text = valueText
    }
}
