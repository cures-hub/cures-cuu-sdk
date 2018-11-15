//
//  UpperLidRaiser.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.12.17.
//

import Foundation

struct EKCheekRaiser: EKActionUnit {
    let probability: Float

    init(from face: EKFace) {
        probability = max(face.cheekSquintLeft, face.cheekSquintRight)
    }
}
