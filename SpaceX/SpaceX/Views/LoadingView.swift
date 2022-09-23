//
//  LoadingView.swift
//  SpaceX
//
//  Created by Эван Крошкин on 21.09.22.
//

import SnapKit
import UIKit

class LoadingView: UIView {
    
    // MARK: - Private properties
    
    private lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.3
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
    
    // MARK: - Initializer
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        layer.zPosition = 999
        self.addSubview(blurEffectView)
        self.addSubview(loadingActivityIndicator)
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        blurEffectView.frame = bounds
        insertSubview(blurEffectView, at: 0)
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadingActivityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
