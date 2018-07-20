//
//  IKCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 08.02.18.
//

import Foundation

/**
 *  CUUCrumb protocol implementation for Interaction Crumbs.
 **/
public class IKCrumb: IKInteraction {
    
    // MARK: - Properties
    
    public let name: String
    public let timestamp: Date
    public let sessionId: String
    public let userId: String
    public var characteristics : CUUCharacteristics?
    
    // MARK: - Lifecycle
    
    init(name: String) {
        self.name = name
        self.timestamp = Date()
        self.sessionId = CUUSessionManager.sharedManager.currentSession
        self.userId = CUUUserManager.sharedManager.userId
        self.characteristics = IKDefaultCharacteristics()
    }
}
