//
//  AppDelegate.swift
//  SpaceX
//
//  Created by Эван Крошкин on 29.08.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let navigationController = UINavigationController()
    let assemblyBuilder = AssemblyModuleBuilder()
    var deviceOrientation = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return deviceOrientation
    }
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let router = Router(navigationController: navigationController,
                            assemblyBuilder: assemblyBuilder)
        router.initViewController()
        navigationController.isNavigationBarHidden = true
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = .white
        window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

