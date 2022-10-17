//
//  CoreDataManager.swift
//  SpaceX
//
//  Created by Эван Крошкин on 17.10.22.
//

import Foundation
import CoreData

enum ContextType {
    case main
    case background
}

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    func entityForName(entityName: String,
                       contextType: ContextType) -> NSEntityDescription {
        switch contextType {
        case .main:
            return NSEntityDescription.entity(forEntityName: entityName,
                                              in: self.managedObjectContext)!
        case .background:
            return NSEntityDescription.entity(forEntityName: entityName,
                                              in: self.managetObjectBackgroundContext)!
        }
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer:  NSPersistentContainer  = {

        let container = NSPersistentContainer(name: "DeliverPizzaApp")
        
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        // New data adding in save data (if conflict)
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        
        // automatically merge data
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
    }()
    
    /// main thread context
    lazy var managedObjectContext: NSManagedObjectContext = persistentContainer.viewContext
    
    /// background context
    lazy var managetObjectBackgroundContext: NSManagedObjectContext = persistentContainer.newBackgroundContext()

    // MARK: - Core Data Saving support
    func saveContext () {
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveBackgroundContext () {
        managetObjectBackgroundContext.performAndWait {
            if managetObjectBackgroundContext.hasChanges {
                do {
                    try managetObjectBackgroundContext.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
}
