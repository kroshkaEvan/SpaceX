//
//  RocketPresenter.swift
//  SpaceX
//
//  Created by Эван Крошкин on 12.09.22.
//

import UIKit

protocol RocketPresenterProtocol: AnyObject {
    init(view: RocketViewProtocol,
         network: NetworkProtocol,
         router: RouterProtocol)
    
    var rockets: [Rocket]? { get set }
    
    func fetchRockets()
}

class RocketPresenter: RocketPresenterProtocol {
    // MARK: - Properties
    
    let view: RocketViewProtocol?
    let network: NetworkProtocol?
    var router: RouterProtocol?
    var rockets: [Rocket]?
    
    // MARK: - Initializater
    
    required init(view: RocketViewProtocol,
                  network: NetworkProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.network = network
        self.router = router
        fetchRockets()
    }
    
    // MARK: - Methods
    
    func fetchRockets() {
        network?.fetchRockets { [weak self] (result) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(rocket):
                    self.rockets = rocket
                    self.view?.success()
                case let .failure(error):
                    self.view?.failure(error: error)
                }
                return
            }
        }
    }
    
}

