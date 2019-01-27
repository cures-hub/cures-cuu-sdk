//
//  FKActionCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 10.12.17.
//

/**
 *  CUUCrumb protocol implementation for Action Crumbs.
 **/
struct FKActionCrumb : CUUCrumb {
    let id = UUID().uuidString
    let name: String
    let type = CUUConstants.CrumbTypes.actionCrumb
    let timestamp: Date
    let sessionId: String
    let userId: String
    var characteristics : CUUCharacteristics?
    
    init(name: String) {
        self.name = name
        self.timestamp = Date()
        self.sessionId = CUUSessionManager.sharedManager.currentSession
        self.userId = CUUUserManager.sharedManager.userId
    }
}
