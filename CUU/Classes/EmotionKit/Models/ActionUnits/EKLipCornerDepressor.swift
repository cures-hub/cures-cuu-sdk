//
//  LipCornerDepressor.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 09.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKLipCornerDepressor: EKActionUnit {
    let probability: Float

    init(from face: EKFace) {
        probability = max(face.mouthFrownLeft, face.mouthFrownRight)
    }

}

