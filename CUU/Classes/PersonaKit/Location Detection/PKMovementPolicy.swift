//
//  PKMovementPolicy.swift
//  CUU
//
//  Created by Florian Fittschen on 15.08.18.
//

import Foundation

class PKMovementPolicy: PKLocationDetectionPolicy {
    private let movementDetector = PKMovementDetector()

    private var isMoving: Bool {
        return movementDetector.moving
    }

    init() {
        movementDetector.start()
    }

    deinit {
        movementDetector.stop()
    }

    func calculateScore(for locationType: PKLocationType) -> Double {
        switch (locationType, isMoving) {
        case (.transit, true):
            return 0.9
        case (.outdoor, true):
            return 0.7
        case (.home, false):
            return 0.6
        case (.home, true), (.office, false):
            return 0.4
        case (.outdoor, false):
            return 0.3
        case (.office, true), (.transit, false):
            return 0.1
        }
    }
}
