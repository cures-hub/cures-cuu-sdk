//
//  Surprise.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 09.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKSurprise: EKEmotion {
    static let type = EKEmotionType.surprise
    let emoji = "😯"

    var probability: Float

    init(given actionUnits: [EKActionUnit]) {
        let innerBrowRaiser: EKInnerBrowRaiser? = actionUnits.inferByType()
        let outerBrowRaiser: EKOuterBrowRaiser? = actionUnits.inferByType()
        let upperLidRaiser: EKUpperLidRaiser? = actionUnits.inferByType()
        let jawDrop: EKJawDrop? = actionUnits.inferByType()
        
        probability = EKSurprise.getProbability(of: innerBrowRaiser) * (2/7)
            + EKSurprise.getProbability(of: outerBrowRaiser) * (2/7)
            + EKSurprise.getProbability(of: upperLidRaiser) * (1/7)
            + EKSurprise.getProbability(of: jawDrop) * (2/7)
    }

}
