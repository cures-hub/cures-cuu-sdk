//
//  PKTraitDetector.swift
//  CUU
//
//  Created by Florian Fittschen on 16.08.18.
//

import Foundation

struct PKTraitDetector {

    static func detectTraits(for session: PKSession) -> [PKTraitType] {
        var result: Set<PKTraitType> = []

        if session.percentageOfPreciseTouches > 0.6 {
            result.insert(.precise)
        }
        if session.isHasty {
            result.insert(.hasty)
        }
        if session.isAdventurous {
            result.insert(.adventurous)
        }
        if session.isFearless {
            result.insert(.fearless)
        }
        if let averageTimeOnMostVisitedScene = session.averageTimeOnMostVisitedScene,
            averageTimeOnMostVisitedScene > 15 {
            result.insert(.focused)
        }
        if !result.contains(.adventurous) && session.isConfused {
            result.insert(.confused)
        }
        if let averageTimeBetweenTouches = session.averageTimeBetweenTouches, averageTimeBetweenTouches < 1 {
            result.insert(.theFlash)
        }
        
        return Array(result)
    }

    
}
