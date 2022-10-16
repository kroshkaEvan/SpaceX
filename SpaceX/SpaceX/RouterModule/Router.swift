//
//  Router.swift
//  SpaceX
//
//  Created by Эван Крошкин on 12.09.22.
//

import UIKit

protocol RouterRocket {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol {
    var saveUserDefaults: (() -> Void)? { get set }
    func initViewController()
    func pushLaunchVC(viewController: UIViewController,
                      typeRocket: String,
                      rocketName: String)
    func presentSettingsVC(viewController: UIViewController)
    func dismissSettingsVC(viewController: UIViewController)
}

class Router: RouterRocket {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var saveUserDefaults: (() -> Void)?
    
    // MARK: - Initializater
    
    init(navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
}

extension Router: RouterProtocol {
    
    func initViewController() {
        guard let pageViewController = assemblyBuilder?.setMainPageModule(router: self),
              let navigationController = navigationController else { return }
        navigationController.viewControllers = [pageViewController]
    }
    
    func pushLaunchVC(viewController: UIViewController,
                      typeRocket: String,
                      rocketName: String) {
        guard let launchVC = assemblyBuilder?.setLaunchModule(router: self,
                                                              typeRocket: typeRocket,
                                                              rocketName: rocketName) else { return }
        viewController.navigationController?.pushViewController(launchVC,
                                                                animated: true)
    }
    
    func presentSettingsVC(viewController: UIViewController) {
        guard let settingsListViewController = assemblyBuilder?.setSettingModule(router: self) else { return }
        let navController = UINavigationController(rootViewController: settingsListViewController)
        viewController.navigationController?.present(navController, animated: true)
    }
    
    func dismissSettingsVC(viewController: UIViewController) {
        viewController.dismiss(animated: true,
                               completion: saveUserDefaults)
    }
    
}


