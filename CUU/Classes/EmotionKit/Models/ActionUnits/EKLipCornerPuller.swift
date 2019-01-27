//
//  LipCornerPuller.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 23.12.17.
//

import Foundation

struct EKLipCornerPuller: EKActionUnit {
    let probability: Float

    init(from face: EKFace) {
        probability = max(face.mouthSmileLeft, face.mouthSmileRight)
    }
}
