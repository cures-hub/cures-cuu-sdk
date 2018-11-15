//
//  NasolabialDeepener.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKNasolabialDeepener: EKActionUnit {
    init(from face: EKFace) {
        probability = (face.mouthShrugUpper + max(face.mouthDimpleLeft, face.mouthDimpleRight)) * 0.5
    }

    var probability: Float


}
