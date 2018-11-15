//
//  FaceScraperFactory.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 10.12.17.
//

import ARKit

open class EKFaceDetectorFactory {
    private static let sharedInstance: EKFaceDetector = EKFaceStateManager()

    static var instance: EKFaceDetector {
        get {
            return sharedInstance
        }
    }

}
