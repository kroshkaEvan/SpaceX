//
//  SettingsPresenter.swift
//  SpaceX
//
//  Created by Эван Крошкин on 15.09.22.
//

import UIKit

protocol SettingsPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol,
         router: RouterProtocol)
    
    var userDefaults: UserDefaultsStorage { get set }
    func closeVC()
}

class SettingsPresenter: SettingsPresenterProtocol {
    // MARK: - Properties
    
    let view: SettingsViewProtocol?
    let router: RouterProtocol?
    
    var userDefaults = UserDefaultsStorage()
    
    // MARK: - Initializater
    
    required init(view: SettingsViewProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func closeVC() {
        guard let view = view as? UIViewController else { return }
        router?.dismissSettingsVC(viewController: view)
    }
}






