//
//  LaunchPresenter.swift
//  SpaceX
//
//  Created by Эван Крошкин on 13.09.22.
//

import UIKit

protocol LaunchPresenterProtocol: AnyObject {
    init(view: LaunchViewProtocol,
         network: NetworkProtocol,
         router: RouterProtocol,
         typeRocket: String,
         rocketName: String)
    
    var launches: [Launch]? { get set }
    var typeRocket: String { get }
    var rocketName: String { get }
    
    func fetchLaunchesData()
    func getLaunchesDataToCell(indexPath: Int,
                               complition: @escaping(String?, String?, String?) -> Void)
    
}

class LaunchPresenter: LaunchPresenterProtocol {
    
    // MARK: - Properties
    
    let view: LaunchViewProtocol?
    let network: NetworkProtocol?
    let router: RouterProtocol?
    
    var launches: [Launch]?
    var typeRocket: String
    var rocketName: String
    
    // MARK: - Initializater
    
    required init(view: LaunchViewProtocol,
                  network: NetworkProtocol,
                  router: RouterProtocol,
                  typeRocket: String,
                  rocketName: String) {
        self.view = view
        self.network = network
        self.router = router
        self.typeRocket = typeRocket
        self.rocketName = rocketName
        fetchLaunchesData()
    }
    
    // MARK: - Methods
    
    func fetchLaunchesData() {
        network?.fetchLaunches { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case let .success(launchData):
                    self.launches = launchData
                    self.launches = self.launches?.filter { data in
                        data.rocket.rawValue == self.typeRocket
                    }
                    if self.launches?.count == 0 {
                        self.view?.successNil()
                    }
                    self.view?.successUpload()
                case let .failure(error):
                    self.view?.failure(error: error)
                }
                return
            }
        }
    }
    
    func getLaunchesDataToCell(indexPath: Int,
                               complition: @escaping(String?, String?, String?) -> Void) {
        let sortRows = self.launches?.sorted(by: { $0.dateLocal > $1.dateLocal })
        let row = sortRows?[indexPath]
        let statusLaunch: String? = row?.success ?? false ? "ok" : "fail"
        complition(row?.name, row?.dateLocal, statusLaunch)
    }
    

}




