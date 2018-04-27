//
//  CUUUserManager.swift
//  CUU
//
//  Created by Lara Marie Reimer on 16.01.18.
//



import Foundation

class CUUUserManager {
    static let sharedManager = CUUUserManager()
    
    let userId: String = {
        let id = UserDefaults.standard.string(forKey: CUUConstants.CUUUserDefaultsKeys.userIdKey)
        
        if let id = id {
            // Return the stored id
            return id
        } else {
            // Return a new id
            // Create a unique id
            let uuid = UUID().uuidString
            
            // Store it in user defaults
            UserDefaults.standard.set(uuid, forKey: CUUConstants.CUUUserDefaultsKeys.userIdKey)
            
            return uuid
        }
    }()
}
