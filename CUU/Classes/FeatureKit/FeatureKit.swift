//
//  FeatureKit.swift
//  CUU
//
//  Created by Lara Marie Reimer on 10.12.17.
//

import Foundation

open class FeatureKit {
    
    open static func seed(name: String) {
        let actionCrumb = FKActionCrumb(name: name)
        
        if let projectId = CUUUtils.projectId, let commitHash = CUUUtils.commitHash, let trackingToken = CUUUtils.trackingToken {
            actionCrumb.send(projectId: projectId, commitHash: commitHash, trackingToken: trackingToken)
        }
    }
}
