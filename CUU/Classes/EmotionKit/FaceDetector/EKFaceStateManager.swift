//
//  FaceStateManager.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 06.12.17.
//

import ARKit

class EKFaceStateManager: NSObject {
    public var emotionMap: [Date: [EKEmotion]] = [:]
}

extension EKFaceStateManager: EKFaceDetector {

    func store(emotions: [EKEmotion], with timestamp: Date = Date()) {
        cleanupEmotionMap()

        guard !(emotionMap.keys.contains { $0.millisecondsSince1970 == timestamp.millisecondsSince1970 })
            else { /* skip element and */ return }

        emotionMap.updateValue(emotions, forKey: timestamp)
    }

    func cleanupEmotionMap() {
        let oneMinuteAgo = Date(timeIntervalSinceNow: -60)
        emotionMap = emotionMap.filter { $0.key > oneMinuteAgo }
    }

    func store(face: EKFace) {
        let actionUnits = convertToActionUnits(from: face)
        let emotions = convertToEmotions(given: actionUnits)
        store(emotions: emotions)
    }

    func detectFace(with blendShapes: [ARFaceAnchor.BlendShapeLocation : NSNumber]) {
        let detectedFace = EKFace(from: blendShapes)
        store(face: detectedFace)
    }

    func detectFace(from anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        detectFace(with: faceAnchor.blendShapes)
    }

    func detectFace(from anchors: [ARAnchor]) {
        anchors.forEach { detectFace(from: $0) }
    }

    func convertToActionUnits(from face: EKFace) -> [EKActionUnit] {
        return [
            EKNeutralFace.self,
            EKInnerBrowRaiser.self,
            EKOuterBrowRaiser.self,
            EKBrowLowerer.self,
            EKUpperLidRaiser.self,
            EKCheekRaiser.self,
            EKLidTightener.self,
            EKLipsTowardEachOther.self,
            EKNoseWrinkler.self,
            EKUpperLipRaiser.self,
            EKNasolabialDeepener.self,
            EKLipCornerPuller.self,
            EKSharpLipPuller.self,
            EKDimpler.self,
            EKLipCornerDepressor.self,
            EKLowerLipDepressor.self,
            EKLipPucker.self,
            EKLipStretcher.self,
            EKLipFunneler.self,
            EKLipTightener.self,
            EKLipPressor.self,
            EKJawDrop.self
        ].from(face)
    }

    func convertToEmotions(given actionUnits: [EKActionUnit]) -> [EKEmotion] {
        return [
            EKHappiness.self,
            EKSadness.self,
            EKSurprise.self,
            EKFear.self,
            EKAnger.self,
            EKDisgust.self,
            EKContempt.self
        ].given(actionUnits)
    }
}
