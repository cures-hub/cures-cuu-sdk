//
//  FKActionCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 10.12.17.
//

struct FKActionCrumb : CUUCrumb {
    let name: String
    let type = "action"
    let timestamp: Date
    let sessionId: String
    let userId: String
    
    init(name: String) {
        self.name = name
        self.timestamp = Date()
        self.sessionId = CUUSessionManager.sharedManager.currentSession
        self.userId = CUUUserManager.sharedManager.userId
    }
}
