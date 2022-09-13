//
//  RocketPresenter.swift
//  SpaceX
//
//  Created by Эван Крошкин on 12.09.22.
//

import UIKit
import Nuke

protocol RocketPresenterProtocol: AnyObject {
    init(view: RocketViewProtocol,
         network: NetworkProtocol,
         router: RouterProtocol)
    
    var rockets: [Rocket]? { get set }
    func fetchRockets()
    func fetchRocketImage(_ imageView: UIImageView,
                          with serialNumber: Int)
    func openLaunchVC(viewController: UIViewController,
                      idRocket: String,
                      rocketName: String)
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
                    self.view?.successUpload()
                case let .failure(error):
                    self.view?.failure(error: error)
                }
                return
            }
        }
    }
    
    func fetchRocketImage(_ imageView: UIImageView,
                          with serialNumber: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  let rocketImageURL = self.rockets?[serialNumber].images.randomElement(),
                  let url = URL(string: rocketImageURL) else { return }
            let options = ImageLoadingOptions(
                placeholder: UIImage(named: "SpaceX")
            )
            Nuke.loadImage(with: url,
                           options: options,
                           into: imageView)
        }
    }
    
    func openLaunchVC(viewController: UIViewController,
                      idRocket: String,
                      rocketName: String) {
        router?.pushLaunchVC(viewController: viewController,
                             typeRocket: idRocket,
                             rocketName: rocketName)
    }
}

