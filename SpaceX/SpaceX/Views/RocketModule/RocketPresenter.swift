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
    var userDefaults: UserDefaultsStorage { get set }
    
    func fetchRockets()
    func fetchRocketImage(_ imageView: UIImageView,
                          with serialNumber: Int)
    func openLaunchVC(serialNumber: Int)
    func openSettingsVC()
    func updateView()
}

class RocketPresenter: RocketPresenterProtocol {
    // MARK: - Properties
    
    let view: RocketViewProtocol?
    let network: NetworkProtocol?
    var router: RouterProtocol?
    var rockets: [Rocket]?
    var userDefaults = UserDefaultsStorage()

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
    
    func openLaunchVC(serialNumber: Int) {
        guard let view = view as? UIViewController else { return }
        router?.pushLaunchVC(viewController: view,
                             typeRocket: rockets?[serialNumber].id ?? "",
                             rocketName: rockets?[serialNumber].name ?? "")
    }
    
    func openSettingsVC() {
        guard let view = view as? UIViewController else { return }
        router?.presentSettingsVC(viewController: view)
    }
    
    func updateView() {
        router?.saveUserDefaults = {
            self.view?.successSaveUserDefaults()
        }
    }
}

