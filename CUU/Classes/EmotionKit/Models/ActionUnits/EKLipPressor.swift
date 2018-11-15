//
//  LipPressor.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKLipPressor: EKActionUnit {
    init(from face: EKFace) {
        probability = max(face.mouthPressLeft, face.mouthPressRight)
    }
    
    var probability: Float
}
