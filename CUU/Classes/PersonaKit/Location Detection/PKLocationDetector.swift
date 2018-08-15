//
//  PKLocationDetector.swift
//  CUU
//
//  Created by Florian Fittschen on 14.08.18.
//

import Foundation
import CoreMotion

typealias PKLocation = (type: PKLocationType, confidence: PKConfidence)
typealias PKLocationPolicyResult = [PKLocationType: Double]

class PKLocationDetector {
    private var policies: [PKLocationDetectionPolicy] = []

    init() {
        guard let reachabilityPolicy = PKReachabilityPolicy() else {
            preconditionFailure("Could not init PKReachabilityPolicy")
        }

        policies.append(reachabilityPolicy)
        policies.append(PKDateTimePolicy())
        policies.append(PKMovementPolicy())
    }

    func detectLocation() -> PKLocation? {
        var aggregateResults: PKLocationPolicyResult = [:]
        policies.forEach { policy in
            aggregateResults.merge(policy.calculateScores(), uniquingKeysWith: +)
        }
        aggregateResults.forEach { key, value in
            aggregateResults[key] = value / Double(policies.count)
        }
        guard let locationWithHighestScore = aggregateResults.max(by: { $0.value < $1.value }) else {
            return nil
        }

        return (locationWithHighestScore.key, PKConfidence(from: locationWithHighestScore.value))
    }
}
