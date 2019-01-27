//
//  Happiness.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 23.12.17.
//

import Foundation

struct EKHappiness: EKEmotion {
    static let type = EKEmotionType.happiness
    let emoji = "😊"

    var probability: Float

    init(given actionUnits: [EKActionUnit]) {
        let cheekRaiser: EKCheekRaiser? = actionUnits.inferByType()
        let lipCornerPull: EKLipCornerPuller? = actionUnits.inferByType()

        probability = (EKHappiness.getProbability(of: cheekRaiser) + EKHappiness.getProbability(of: lipCornerPull)) / 2
    }

}
