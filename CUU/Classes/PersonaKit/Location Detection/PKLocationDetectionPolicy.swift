//
//  PKLocationDetectionPolicy.swift
//  CUU
//
//  Created by Florian Fittschen on 15.08.18.
//

import Foundation

protocol PKLocationDetectionPolicy {
    func calculateScore(for locationType: PKLocationType) -> Double
}

extension PKLocationDetectionPolicy {
    func calculateScores() -> PKLocationPolicyResult {
        var result: PKLocationPolicyResult = [:]
        PKLocationType.allCases.forEach { locationType in
            result[locationType] = calculateScore(for: locationType)
        }
        return result
    }
}
