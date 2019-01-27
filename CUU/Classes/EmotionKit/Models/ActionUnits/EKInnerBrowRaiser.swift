//
//  InnerBrowRaiser.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.12.17.
//

import Foundation

struct EKInnerBrowRaiser: EKActionUnit {
    let probability: Float
    
    init(from face: EKFace) {
        probability = face.browInnerUp
    }
}
