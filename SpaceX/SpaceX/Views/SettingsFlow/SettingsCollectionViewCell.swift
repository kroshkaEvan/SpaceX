//
//  SettingsTableViewCell.swift
//  SpaceX
//
//  Created by Эван Крошкин on 11.09.22.
//

import UIKit
import SnapKit

class SettingsTableViewCell: UITableViewCell {
    static let identifier = "SettingsCollectionViewCell"
    
    // MARK: - Public properties
        
    private lazy var parameterLabel: UILabel = {
        let label = UILabel()
        label.text = "Mass"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var valueSegmentedControl: UISegmentedControl = {
        let font = UIFont.systemFont(ofSize: 17.5)
        let segmentedItems = ["", ""]
        let segmentedControl = UISegmentedControl(items: segmentedItems)
        segmentedControl.setTitleTextAttributes([.font: font,
                                                 .foregroundColor: UIColor.black],
                                                for: .selected)
        segmentedControl.setTitleTextAttributes([.font: font,
                                                 .foregroundColor: UIColor.lightGray],
                                                for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: reuseIdentifier)
        setupCellLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupCellLayout() {
        backgroundColor = .clear
        selectionStyle = .none
        var configuration = self.defaultContentConfiguration()
        configuration.textProperties.adjustsFontSizeToFitWidth = true
        contentConfiguration = configuration

        [valueSegmentedControl, parameterLabel].forEach( {addSubview($0)} )
        
        valueSegmentedControl.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().offset(-28)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(115)
        })

        parameterLabel.snp.makeConstraints({ make in
            make.leading.equalToSuperview().offset(28)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        })
    }
    
    func configureCell(parameterText: String,
                       segmentedItems: [String]) {
        parameterLabel.text = parameterText
        valueSegmentedControl.setTitle(segmentedItems[0],
                                       forSegmentAt:0)
        valueSegmentedControl.setTitle(segmentedItems[1],
                                       forSegmentAt:1)
    }
}

