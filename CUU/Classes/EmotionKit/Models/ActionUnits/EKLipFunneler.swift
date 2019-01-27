//
//  LipFunneler.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKLipFunneler: EKActionUnit {
    init(from face: EKFace) {
        probability = face.mouthFunnel
    }

    var probability: Float
}
