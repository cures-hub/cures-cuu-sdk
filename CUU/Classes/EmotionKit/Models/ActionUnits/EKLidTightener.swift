//
//  LidTightener.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKLidTightener: EKActionUnit {
    init(from face: EKFace) {
        probability = max(face.eyeSquintLeft, face.eyeSquintRight)
    }

    var probability: Float


}
