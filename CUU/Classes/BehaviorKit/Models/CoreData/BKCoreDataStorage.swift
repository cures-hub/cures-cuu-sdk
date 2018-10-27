//
//  BKCoreDataStorage.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.10.18.
//

import Foundation
import CoreData

class BKCoreDataStorage: BKStorage {
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: "BKData", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let container = NSPersistentContainer(name: "BKData", managedObjectModel: mom)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error initializing container")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func commit(_ object: BKEncodedData, completion: ((Bool, Error?) -> Void)?) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving data")
            }
        }
    }
    
    func fetch(predicate: NSPredicate?, completion: (Array<BKEncodedData>) -> Void) {
        var results : [BKEncodedData] = []
        let request = NSFetchRequest<BKEncodedData>(entityName: String(describing: BKEncodedData.self))
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
