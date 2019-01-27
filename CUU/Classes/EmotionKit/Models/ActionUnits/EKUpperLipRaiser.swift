//
//  UpperLipRaiser.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKUpperLipRaiser: EKActionUnit {
    init(from face: EKFace) {
        probability = (face.mouthShrugUpper + max(face.mouthUpperUpLeft, face.mouthUpperUpRight)) * 0.5
    }

    var probability: Float


}
