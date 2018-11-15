//
//  Anger.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 09.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKAnger: EKEmotion {
    static let type = EKEmotionType.anger
    let emoji = "😡"

    var probability: Float

    init(given actionUnits: [EKActionUnit]) {
        let browLowerer: EKBrowLowerer? = actionUnits.inferByType()
        let upperLidRaiser: EKUpperLidRaiser? = actionUnits.inferByType()
        let lidTightener: EKLidTightener? = actionUnits.inferByType()
        let lipTightener: EKLipTightener? = actionUnits.inferByType()
        
        probability = (
            EKAnger.getProbability(of: browLowerer) +
            EKAnger.getProbability(of: upperLidRaiser) +
            EKAnger.getProbability(of: lidTightener) +
            EKAnger.getProbability(of: lipTightener)
        ) / 4
    }

}
