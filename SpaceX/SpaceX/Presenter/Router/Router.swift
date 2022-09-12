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
    func initViewController()
}

class Router: RouterRocket {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
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
}


