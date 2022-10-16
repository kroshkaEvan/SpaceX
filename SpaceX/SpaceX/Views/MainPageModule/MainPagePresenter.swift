//
//  MainPagePresenter.swift
//  SpaceX
//
//  Created by Эван Крошкин on 12.09.22.
//

import Foundation
import UIKit

protocol MainPagePresenterProtocol: AnyObject {
    init(view: MainPageViewProtocol,
         network: NetworkProtocol,
         router: RouterProtocol,
         assemblyBuilder: AssemblyBuilderProtocol)
    
    var rockets: [Rocket]? { get set }
    func fetchRockets()
    func setPages()
}

class MainPagePresenter: MainPagePresenterProtocol {
    // MARK: - Properties
    
    let view: MainPageViewProtocol?
    let network: NetworkProtocol?
    let router: RouterProtocol?
    let assemblyBuilder: AssemblyBuilderProtocol?
    var rockets: [Rocket]?
    
    // MARK: - Initializater
    
    required init(view: MainPageViewProtocol,
                  network: NetworkProtocol,
                  router: RouterProtocol,
                  assemblyBuilder: AssemblyBuilderProtocol) {
        self.view = view
        self.network = network
        self.router = router
        self.assemblyBuilder = assemblyBuilder
        fetchRockets()
    }
    
    // MARK: - Methods
    
    func fetchRockets() {
        network?.fetchRockets { [weak self] (result) in
            guard let self = self else { return }
            self.view?.isShowLoadingView(true)
            DispatchQueue.main.async {
                switch result {
                case let .success(rocket):
                    self.rockets = rocket
                    self.view?.successUpload()
                    self.view?.isShowLoadingView(false)
                case let .failure(error):
                    self.view?.failure(error: error)
                }
                return
            }
        }
    }
    
    func setPages() {
        guard let rockets = rockets?.count,
              let router = router as? Router,
              let assemblyBuilder = assemblyBuilder else { return }
        for serialNumber in 0..<rockets {
            let viewController = assemblyBuilder.setRocketModule(router: router,
                                                                 with: serialNumber)
            view?.pages.append(viewController)
        }
    }
}





