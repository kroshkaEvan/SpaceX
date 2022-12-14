//
//  AssemblyBuilder.swift
//  SpaceX
//
//  Created by Эван Крошкин on 12.09.22.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func setMainPageModule(router: Router) -> UIViewController
    func setRocketModule(router: Router,
                         with serialNumber: Int) -> UIViewController
    func setLaunchModule(router: Router,
                         typeRocket: String,
                         rocketName: String) -> UIViewController
    func setSettingModule(router: Router) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func setMainPageModule(router: Router) -> UIViewController {
        let networkManager = NetworkManager()
        let view = MainPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)
        let presenter = MainPagePresenter(view: view,
                                          network: networkManager,
                                          router: router,
                                          assemblyBuilder: self)
        view.presenter = presenter
        return view
    }
    
    func setRocketModule(router: Router,
                         with serialNumber: Int) -> UIViewController {
        let networkManager = NetworkManager()
        let view = RocketViewController(serialNumber: serialNumber)
        let presenter = RocketPresenter(view: view,
                                        network: networkManager,
                                        router: router)
        view.presenter = presenter
        return view
    }
    
    func setLaunchModule(router: Router,
                         typeRocket: String,
                         rocketName: String) -> UIViewController {
        let networkManager = NetworkManager()
        let view = LaunchViewController()
        let presenter = LaunchPresenter(view: view,
                                        network: networkManager,
                                        router: router,
                                        typeRocket: typeRocket,
                                        rocketName: rocketName)
        view.presenter = presenter
        return view
    }
    
    func setSettingModule(router: Router) -> UIViewController {
        let view = SettingsViewController()
        let presenter = SettingsPresenter(view: view,
                                          router: router)
        view.presenter = presenter
        return view
    }
    
}
    

