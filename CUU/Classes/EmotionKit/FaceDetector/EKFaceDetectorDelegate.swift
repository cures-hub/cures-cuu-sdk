//
//  FaceDetectorDelegate.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 06.12.17.
//

import Foundation
import ARKit

protocol EKFaceDetector {
    var emotionMap: [Date: [EKEmotion]] { get }
    func detectFace(from anchors: [ARAnchor])
}
