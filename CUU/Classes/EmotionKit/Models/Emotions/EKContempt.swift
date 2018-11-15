//
//  Contempt.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 09.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKContempt: EKEmotion {
    static let type = EKEmotionType.contempt
    let emoji = "🙄"

    var probability: Float

    init(given actionUnits: [EKActionUnit]) {
        let lipCornerPuller: EKLipCornerPuller? = actionUnits.inferByType()
        let dimpler: EKDimpler? = actionUnits.inferByType()
        probability = (EKContempt.getProbability(of: lipCornerPuller) + EKContempt.getProbability(of: dimpler)) / 2
    }

}
