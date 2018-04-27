//
//  FKSessionManager.swift
//  CUU
//
//  Created by Lara Marie Reimer on 18.12.17.
//

class CUUSessionManager {
    static let sharedManager = CUUSessionManager()
    
    let currentSession: String = {
        return UUID().uuidString
    }()
}
