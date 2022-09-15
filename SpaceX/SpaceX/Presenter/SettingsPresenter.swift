//
//  SettingsPresenter.swift
//  SpaceX
//
//  Created by Эван Крошкин on 15.09.22.
//

import UIKit

protocol SettingsPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol,
         network: NetworkProtocol,
         router: RouterProtocol)
}

class SettingsPresenter: SettingsPresenterProtocol {
    // MARK: - Properties
    
    let view: SettingsViewProtocol?
    let network: NetworkProtocol?
    let router: RouterProtocol?
    
    // MARK: - Initializater
    
    required init(view: SettingsViewProtocol,
                  network: NetworkProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.network = network
        self.router = router
    }
    
}






