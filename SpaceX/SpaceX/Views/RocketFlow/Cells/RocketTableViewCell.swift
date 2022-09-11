//
//  RocketTableViewCell.swift
//  SpaceX
//
//  Created by Эван Крошкин on 1.09.22.
//

import UIKit

class RocketTableViewCell: UITableViewCell {
    static let identifier = "RocketTableViewCell"
    
    // MARK: - Public properties
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var parameterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        selectionStyle = .none
        backgroundColor = .black
        var configuration = self.defaultContentConfiguration()
        configuration.textProperties.adjustsFontSizeToFitWidth = true
        contentConfiguration = configuration
        
        [parameterLabel, valueLabel].forEach { addSubview($0) }
        
        parameterLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(176)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    func configureCell(parameterText: String,
                       valueText: String) {
        parameterLabel.text = parameterText
        valueLabel.text = valueText
    }
}
