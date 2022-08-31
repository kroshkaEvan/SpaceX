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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    lazy var rocketName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.text = "rocket name"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        [backgroundImageView, contentView].forEach( {addSubview($0)} )
        [rocketName].forEach( {contentView.addSubview($0)} )
        
        backgroundImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(300)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(backgroundImageView.snp.bottom).offset(20)
        }
        
        rocketName.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(32)
            make.top.equalToSuperview()
        }
    }
    
}
