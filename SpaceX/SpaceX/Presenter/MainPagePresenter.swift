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
         router: RouterProtocol)
    
    var rockets: [Rocket]? { get set }
    
    func fetchRockets()
}

class MainPagePresenter: MainPagePresenterProtocol {
    // MARK: - Properties
    
    let view: MainPageViewProtocol?
    let network: NetworkProtocol?
    let router: RouterProtocol?
    var rockets: [Rocket]?
    
    // MARK: - Initializater
    
    required init(view: MainPageViewProtocol,
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
                    self.view?.success(withNumber: self.rockets?.count ?? 0)
                case .failure(_): break
                }
                return
            }
        }
    }
}





