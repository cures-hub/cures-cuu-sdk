//
//  Sadness.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 23.12.17.
//  Copyright © 2017 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKSadness: EKEmotion {
    static let type = EKEmotionType.sadness
    let emoji = "😢"

    var probability: Float

    init(given actionUnits: [EKActionUnit]) {
        let innerBrowRaiser: EKInnerBrowRaiser? = actionUnits.inferByType()
        let browLowerer: EKBrowLowerer? = actionUnits.inferByType()
        let lipCornerDepressor: EKLipCornerDepressor? = actionUnits.inferByType()

        probability = EKSadness.getProbability(of: innerBrowRaiser) * 0.3
            + EKSadness.getProbability(of: browLowerer) * 0.5
            + EKSadness.getProbability(of: lipCornerDepressor) * 0.2
    }

}
