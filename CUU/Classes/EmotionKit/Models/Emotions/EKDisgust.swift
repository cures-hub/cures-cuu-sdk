//
//  Disgust.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 09.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKDisgust: EKEmotion {
    static let type = EKEmotionType.disgust
    let emoji = "🤢"

    var probability: Float

    init(given actionUnits: [EKActionUnit]) {
        let noseWrinkler: EKNoseWrinkler? = actionUnits.inferByType()
        let lipCornerDepressor: EKLipCornerDepressor? = actionUnits.inferByType()
        let lowerLipDepressor: EKLowerLipDepressor? = actionUnits.inferByType()
        
        probability = (
            EKDisgust.getProbability(of: noseWrinkler) +
            EKDisgust.getProbability(of: lipCornerDepressor) +
            EKDisgust.getProbability(of: lowerLipDepressor)
        ) / 3
    }

}
