//
//  CUUNetworkManager.swift
//  CUU
//
//  Created by Lara Marie Reimer on 16.10.18.
//

import Foundation

class CUUNetworkManager {
    var timer : Timer? = nil
    
    var lastFetchDate : Date? {
        get {
            return UserDefaults.standard.object(forKey: CUUConstants.CUUUserDefaultsKeys.lastFetchDateKey) as? Date
        }
    }
    
    func start() {
        timer = Timer(timeInterval: 60, target: self, selector: #selector(timerDidFire), userInfo: nil, repeats: true)
    }
    
    @objc func timerDidFire() {
        // First, get all data from the databases.
        var predicate : NSPredicate? = nil
        if let lastFetchDate = lastFetchDate {
            predicate = NSPredicate(format: "startDate > %@", lastFetchDate as CVarArg)
        }
        var networkObjects : [CUUNetworkObject] = []
        
        // Reset the date for the last fetch.
        UserDefaults.standard.set(Date(), forKey: CUUConstants.CUUUserDefaultsKeys.lastFetchDateKey)
        
        InteractionKit.shared.fetch(IKInteraction.self, predicate: predicate, completion: { results in
            
            let processedObjects = results.map({ (interaction) -> CUUNetworkObject? in
                // Try to serialize interaction data.
                
                do {
                    let encoder = JSONEncoder()
                    encoder.dateEncodingStrategy = .iso8601
                    let json = try encoder.encode(interaction)
                    let networkObject = CUUNetworkObject.init(type: CUUConstants.CrumbTypes.interactionCrumb, payload: json)
                    return networkObject
                } catch _ {
                    print ("Error serializing interaction")
                    return nil
                }
            }).filter({ (networkObject) -> Bool in
                return (networkObject != nil)
            }).map({ $0! })
            
            networkObjects.append(contentsOf: processedObjects)
        })
        
        // Send the request.
    }
    
    func send(networkObjectsToSend: [CUUNetworkObject]) {
        
    }    
}
