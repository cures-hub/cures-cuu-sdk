//
//  NKDefaultFeedback.swift
//  CUU
//
//  Created by Lara Marie Reimer on 22.09.18.
//

import Foundation

struct NKDefaultFeedback: NKFeedback {
    let content: String
    let timestamp: Date
    let sessionId: String
    let userId: String
    
    init(content: String) {
        self.content = content
        self.timestamp = Date()
        self.sessionId = CUUSessionManager.sharedManager.currentSession
        self.userId = CUUUserManager.sharedManager.userId
    }
}
