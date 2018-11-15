//
//  Face.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 05.12.17.
//  Copyright © 2017 Jan Philip Bernius. All rights reserved.
//

import Foundation

struct EKFace {
    // MARK: Left Eye

    /// The coefficient describing closure of the eyelids over the left eye.
    let eyeBlinkLeft: Float

    /// The coefficient describing movement of the left eyelids consistent with a downward gaze.
    let eyeLookDownLeft: Float

    /// The coefficient describing movement of the left eyelids consistent with a rightward gaze.
    let eyeLookInLeft: Float

    /// The coefficient describing movement of the left eyelids consistent with a leftward gaze.
    let eyeLookOutLeft: Float

    /// The coefficient describing movement of the left eyelids consistent with an upward gaze.
    let eyeLookUpLeft: Float

    /// The coefficient describing contraction of the face around the left eye.
    let eyeSquintLeft: Float

    /// The coefficient describing a widening of the eyelids around the left eye.
    let eyeWideLeft: Float

    // MARK: Right Eye

    /// The coefficient describing closure of the eyelids over the right eye.
    let eyeBlinkRight: Float

    /// The coefficient describing movement of the right eyelids consistent with a downward gaze.
    let eyeLookDownRight: Float

    /// The coefficient describing movement of the right eyelids consistent with a leftward gaze.
    let eyeLookInRight: Float

    /// The coefficient describing movement of the right eyelids consistent with a rightward gaze.
    let eyeLookOutRight: Float

    /// The coefficient describing movement of the right eyelids consistent with an upward gaze.
    let eyeLookUpRight: Float

    /// The coefficient describing contraction of the face around the right eye.
    let eyeSquintRight: Float

    /// The coefficient describing a widening of the eyelids around the right eye.
    let eyeWideRight: Float

    // MARK: Mouth and Jaw

    /// The coefficient describing forward movement of the lower jaw.
    let jawForward: Float

    /// The coefficient describing leftward movement of the lower jaw.
    let jawLeft: Float

    /// The coefficient describing rightward movement of the lower jaw.
    let jawRight: Float

    /// The coefficient describing an opening of the lower jaw.
    let jawOpen: Float

    /// The coefficient describing closure of the lips independent of jaw position.
    let mouthClose: Float

    /// The coefficient describing contraction of both lips into an open shape.
    let mouthFunnel: Float

    /// The coefficient describing contraction and compression of both closed lips.
    let mouthPucker: Float

    /// The coefficient describing leftward movement of both lips together.
    let mouthLeft: Float

    /// The coefficient describing rightward movement of both lips together.
    let mouthRight: Float

    /// The coefficient describing upward movement of the left corner of the mouth.
    let mouthSmileLeft: Float

    /// The coefficient describing upward movement of the right corner of the mouth.
    let mouthSmileRight: Float

    /// The coefficient describing downward movement of the left corner of the mouth.
    let mouthFrownLeft: Float

    /// The coefficient describing downward movement of the right corner of the mouth.
    let mouthFrownRight: Float

    /// The coefficient describing backward movement of the left corner of the mouth.
    let mouthDimpleLeft: Float

    /// The coefficient describing backward movement of the right corner of the mouth.
    let mouthDimpleRight: Float

    /// The coefficient describing leftward movement of the left corner of the mouth.
    let mouthStretchLeft: Float

    /// The coefficient describing rightward movement of the left corner of the mouth.
    let mouthStretchRight: Float

    /// The coefficient describing movement of the lower lip toward the inside of the mouth.
    let mouthRollLower: Float

    /// The coefficient describing movement of the upper lip toward the inside of the mouth.
    let mouthRollUpper: Float

    /// The coefficient describing outward movement of the lower lip.
    let mouthShrugLower: Float

    /// The coefficient describing outward movement of the upper lip.
    let mouthShrugUpper: Float

    /// The coefficient describing upward compression of the lower lip on the left side.
    let mouthPressLeft: Float

    /// The coefficient describing upward compression of the lower lip on the right side.
    let mouthPressRight: Float

    /// The coefficient describing downward movement of the lower lip on the left side.
    let mouthLowerDownLeft: Float

    /// The coefficient describing downward movement of the lower lip on the right side.
    let mouthLowerDownRight: Float

    /// The coefficient describing upward movement of the upper lip on the left side.
    let mouthUpperUpLeft: Float

    /// The coefficient describing upward movement of the upper lip on the right side.
    let mouthUpperUpRight: Float

    // MARK: Eyebrows, Cheeks, and Nose

    /// The coefficient describing downward movement of the outer portion of the left eyebrow.
    let browDownLeft: Float

    /// The coefficient describing downward movement of the outer portion of the right eyebrow.
    let browDownRight: Float

    /// The coefficient describing upward movement of the inner portion of both eyebrows.
    let browInnerUp: Float

    /// The coefficient describing upward movement of the outer portion of the left eyebrow.
    let browOuterUpLeft: Float

    /// The coefficient describing upward movement of the outer portion of the right eyebrow.
    let browOuterUpRight: Float

    /// The coefficient describing outward movement of both cheeks.
    let cheekPuff: Float

    /// The coefficient describing upward movement of the cheek around and below the left eye.
    let cheekSquintLeft: Float

    /// The coefficient describing upward movement of the cheek around and below the right eye.
    let cheekSquintRight: Float

    /// The coefficient describing a raising of the left side of the nose around the nostril.
    let noseSneerLeft: Float

    /// The coefficient describing a raising of the right side of the nose around the nostril.
    let noseSneerRight: Float
}
