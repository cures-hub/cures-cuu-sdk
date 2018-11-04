//
//  DefaultThinkingAloudRecognition.swift
//  CUU
//
//  Created by Lara Marie Reimer on 03.07.18.
//

import Foundation

struct DefaultThinkingAloudRecognition: ThinkingAloudRecognition {
    let sessionId: String
    let userId: String
    let featureId: String
    let previousCrumbId: String
    let content: String
    let timestamp: Date
    let analysis: [String : String]
    
    init(featureId: String, previousCrumbId: String, content: String, analysis: [String : String]) {
        self.sessionId = CUUSessionManager.sharedManager.currentSession
        self.userId = CUUUserManager.sharedManager.userId
        self.featureId = featureId
        self.previousCrumbId = previousCrumbId
        self.content = content
        self.timestamp = Date()
        self.analysis = analysis
    }
}
