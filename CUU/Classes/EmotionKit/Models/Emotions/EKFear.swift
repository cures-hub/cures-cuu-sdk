//
//  Fear.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 09.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKFear: EKEmotion {
    static let type = EKEmotionType.fear
    let emoji = "😨"

    var probability: Float

    init(given actionUnits: [EKActionUnit]) {
        let innerBrowRaiser: EKInnerBrowRaiser? = actionUnits.inferByType()
        let outerBrowRaiser: EKOuterBrowRaiser? = actionUnits.inferByType()
        let browLowerer: EKBrowLowerer? = actionUnits.inferByType()
        let upperLidRaiser: EKUpperLidRaiser? = actionUnits.inferByType()
        let lidTightener: EKLidTightener? = actionUnits.inferByType()
        let lipStretcher: EKLipStretcher? = actionUnits.inferByType()
        let jawDrop: EKJawDrop? = actionUnits.inferByType()
        
        probability = (
            EKFear.getProbability(of: innerBrowRaiser) +
            EKFear.getProbability(of: outerBrowRaiser) +
            EKFear.getProbability(of: browLowerer) +
            EKFear.getProbability(of: upperLidRaiser) +
            EKFear.getProbability(of: lidTightener) +
            EKFear.getProbability(of: lipStretcher) +
            EKFear.getProbability(of: jawDrop)
        ) / 7
    }

}
