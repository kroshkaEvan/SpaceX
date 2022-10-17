//
//  Extension CoreData.swift
//  SpaceX
//
//  Created by Эван Крошкин on 17.10.22.
//

import CoreData
import UIKit

enum ContextType {
    case main
    case background
}

extension CoreDataManager {
    
    func saveNewDataFromServer(models: [Rocket])  {
        
        persistentContainer.performBackgroundTask { managetObjectBackgroundContext in
            
            let fetchRequest: NSFetchRequest<RocketModel> = RocketModel.fetchRequest()
            let result = try? self.managetObjectBackgroundContext.fetch(fetchRequest)
            
            if let result = result, !result.isEmpty {
                
                for element in result {
                    self.managetObjectBackgroundContext.delete(element as NSManagedObject)
                }
                
            }
            
            for model in models {

                let managetObjectProductModel = RocketModel(contextType: .background)

                managetObjectProductModel.name = model.name
                managetObjectProductModel.images = model.images.first
                managetObjectProductModel.stages = model.stages
                managetObjectProductModel.firstFlight = model.firstFlight
                managetObjectProductModel.active = model.active
            }
            self.saveBackgroundContext()
            print("COMPLETE ")
        }
    }
    
    func loadDataFromLocalDatabase() -> [Rocket]? {
        let fetchRequest: NSFetchRequest<RocketModel> = RocketModel.fetchRequest()
        var currentProductModels = [Rocket]()
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            guard !results.isEmpty else { return nil }
            for result in results {
                guard let stages = result.stages as Int,
                      let active = result.active as Bool,
                      let name = result.name,
                      let firstFlight = result.firstFlight,
                      let type = result.type else { continue }
                currentProductModels.append(Rocket(height: nil,
                                                   mass: nil,
                                                   firstStage: nil,
                                                   secondStage: nil,
                                                   engines: nil,
                                                   landingLegs: nil,
                                                   payloadWeights: nil,
                                                   images: nil,
                                                   active: <#T##Bool#>,
                                                   stages: <#T##Int#>,
                                                   firstFlight: firstFlight))
                
            }
            if !currentProductModels.isEmpty {
                return currentProductModels
            } else {
                return nil
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}
