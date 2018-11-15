//
//  FaceExtension.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 05.12.17.
//  Copyright © 2017 Jan Philip Bernius. All rights reserved.
//

import Foundation
import ARKit

extension EKFace {
    init(from blendShapes: [ARFaceAnchor.BlendShapeLocation : NSNumber]) {
        eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as! Float
        eyeLookDownLeft = blendShapes[.eyeLookDownLeft] as! Float
        eyeLookInLeft = blendShapes[.eyeLookInLeft] as! Float
        eyeLookOutLeft = blendShapes[.eyeLookOutLeft] as! Float
        eyeLookUpLeft = blendShapes[.eyeLookUpLeft] as! Float
        eyeSquintLeft = blendShapes[.eyeSquintLeft] as! Float
        eyeWideLeft = blendShapes[.eyeWideLeft] as! Float

        eyeBlinkRight = blendShapes[.eyeBlinkRight] as! Float
        eyeLookDownRight = blendShapes[.eyeLookDownRight] as! Float
        eyeLookInRight = blendShapes[.eyeLookInRight] as! Float
        eyeLookOutRight = blendShapes[.eyeLookOutRight] as! Float
        eyeLookUpRight = blendShapes[.eyeLookUpRight] as! Float
        eyeSquintRight = blendShapes[.eyeSquintRight] as! Float
        eyeWideRight = blendShapes[.eyeWideRight] as! Float

        jawForward = blendShapes[.jawForward] as! Float
        jawLeft = blendShapes[.jawLeft] as! Float
        jawRight = blendShapes[.jawRight] as! Float
        jawOpen = blendShapes[.jawOpen] as! Float

        mouthClose = blendShapes[.mouthClose] as! Float
        mouthFunnel = blendShapes[.mouthFunnel] as! Float
        mouthPucker = blendShapes[.mouthPucker] as! Float
        mouthLeft = blendShapes[.mouthLeft] as! Float
        mouthRight = blendShapes[.mouthRight] as! Float
        mouthSmileLeft = blendShapes[.mouthSmileLeft] as! Float
        mouthSmileRight = blendShapes[.mouthSmileRight] as! Float
        mouthFrownLeft = blendShapes[.mouthFrownLeft] as! Float
        mouthFrownRight = blendShapes[.mouthFrownRight] as! Float
        mouthDimpleLeft = blendShapes[.mouthDimpleLeft] as! Float
        mouthDimpleRight = blendShapes[.mouthDimpleRight] as! Float
        mouthStretchLeft = blendShapes[.mouthStretchLeft] as! Float
        mouthStretchRight = blendShapes[.mouthStretchRight] as! Float
        mouthRollLower = blendShapes[.mouthRollLower] as! Float
        mouthRollUpper = blendShapes[.mouthRollUpper] as! Float
        mouthShrugLower = blendShapes[.mouthShrugLower] as! Float
        mouthShrugUpper = blendShapes[.mouthShrugUpper] as! Float
        mouthPressLeft = blendShapes[.mouthPressLeft] as! Float
        mouthPressRight = blendShapes[.mouthPressRight] as! Float
        mouthLowerDownLeft = blendShapes[.mouthLowerDownLeft] as! Float
        mouthLowerDownRight = blendShapes[.mouthLowerDownRight] as! Float
        mouthUpperUpLeft = blendShapes[.mouthUpperUpLeft] as! Float
        mouthUpperUpRight = blendShapes[.mouthUpperUpRight] as! Float

        browDownLeft = blendShapes[.browDownLeft] as! Float
        browDownRight = blendShapes[.browDownRight] as! Float
        browInnerUp = blendShapes[.browInnerUp] as! Float
        browOuterUpLeft = blendShapes[.browOuterUpLeft] as! Float
        browOuterUpRight = blendShapes[.browOuterUpRight] as! Float

        cheekPuff = blendShapes[.cheekPuff] as! Float
        cheekSquintLeft = blendShapes[.cheekSquintLeft] as! Float
        cheekSquintRight = blendShapes[.cheekSquintRight] as! Float

        noseSneerLeft = blendShapes[.noseSneerLeft] as! Float
        noseSneerRight = blendShapes[.noseSneerRight] as! Float
    }
}
