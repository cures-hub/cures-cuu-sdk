//
//  NoseWrinkler.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.01.18.
//  Copyright © 2018 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKNoseWrinkler: EKActionUnit {
    init(from face: EKFace) {
        probability = max(face.noseSneerLeft, face.noseSneerRight)
    }

    var probability: Float


}
