//
//  NeutralFace.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKNeutralFace: EKActionUnit {
    init(from face: EKFace) {
        probability = 1 - ( (face.jawOpen * 0.5) + (face.mouthClose * 0.5) )
    }

    var probability: Float


}
