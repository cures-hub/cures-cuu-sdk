//
//  PKConfidence.swift
//  CUU
//
//  Created by Florian Fittschen on 14.08.18.
//

import Foundation

enum PKConfidence: String, Codable {
    case low
    case medium
    case high
}

extension PKConfidence {
    init(from score: Double) {
        if score > 0.6 {
            self = .high
        } else if score > 0.3 {
            self = .medium
        } else {
            self = .low
        }
    }
}
