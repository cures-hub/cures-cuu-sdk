//
//  PKTraitDetector.swift
//  CUU
//
//  Created by Florian Fittschen on 16.08.18.
//

import Foundation

struct PKTraitDetector {

    static func detectTraits(for session: PKSession) -> [PKTraitType] {
        var result: [PKTraitType] = []

        if session.percentageOfPreciseTouches > 0.6 {
            result.append(.precise)
        }
        if session.isHasty {
            result.append(.hasty)
        }
        if session.isAdventurous {
            result.append(.adventurous)
        }
        if session.isFearless {
            result.append(.fearless)
        }
        if let averageTimeOnMostVisitedScene = session.averageTimeOnMostVisitedScene,
            averageTimeOnMostVisitedScene > 30 {
            result.append(.focused)
        }
        
        return result
    }

    
}
