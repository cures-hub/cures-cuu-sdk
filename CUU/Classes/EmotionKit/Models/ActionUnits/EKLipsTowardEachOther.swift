//
//  LipsTowardEachOther.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKLipsTowardEachOther: EKActionUnit {
    init(from face: EKFace) {
        probability = (face.jawOpen + face.mouthClose) * 0.5
    }

    var probability: Float


}
