//
//  IKCoreDataStorage.swift
//  CUU
//
//  Created by Lara Marie Reimer on 24.07.18.
//

import Foundation
import CoreData

class IKCoreDataStorage: IKStorage {
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: "IKData", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let container = NSPersistentContainer(name: "IKData", managedObjectModel: mom)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error initializing container")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func commit(_ object: IKCharacteristics, completion: ((Bool, Error?) -> Void)?) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving data")
            }
        }
    }
    
    func commit(_ object: IKInteraction, completion: ((Bool, Error?) -> Void)?) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving data")
            }
        }
    }
    
    func fetch<T>(_ type: T.Type, predicate: NSPredicate?, completion: (Array<IKCharacteristics>) -> Void) where T : IKCharacteristics {
        var results : [IKCharacteristics] = []
        let request = NSFetchRequest<IKCharacteristics>(entityName: String(describing: type))
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        do {
            results = try persistentContainer.viewContext.fetch(request)
        } catch _ {
            print("Error fetching results")
        }   
        
        completion(results)
    }
    
    func fetch<T>(_ type: T.Type, predicate: NSPredicate?, completion: (Array<IKInteraction>) -> Void) where T : IKInteraction {
        var results : [IKInteraction] = []
        let request = NSFetchRequest<IKInteraction>(entityName: String(describing: type))
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        do {
            results = try persistentContainer.viewContext.fetch(request)
        } catch _ {
            print("Error fetching results")
        }
        
        completion(results)
    }
}
