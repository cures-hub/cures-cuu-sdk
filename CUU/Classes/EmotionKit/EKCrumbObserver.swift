//
//  EKCrumbObserver.swift
//  CUU
//
//  Created by Jan Philip Bernius on 10.07.18.
//

import Foundation

class EKCrumbObserver: CUUCrumbObserver {

    private let faceDetector: EKFaceDetector
    private var timer: Timer?

    private let emotionRecordingInterval = 12

    init(faceDetector: EKFaceDetector = EKFaceDetectorFactory.instance) {
        self.faceDetector = faceDetector

        // Register observer for feature crumbs.
        NotificationCenter.default.addObserver(self, selector: #selector(handle(notification:)), name: .didTriggerCrumb, object: nil)
    }

    @objc public func handle(notification: Notification) {
        let payload = notification.userInfo

        if let payload = payload,
            let crumbId = payload["crumbId"] as? String {

            timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(emotionRecordingInterval / 2), repeats: false) {_ in
                let emotionsOfInterest = self.faceDetector.emotionMap.filter {
                    $0.key > Date(timeIntervalSinceNow: TimeInterval(-1 * self.emotionRecordingInterval)) && $0.key <= Date()
                }

                // send away
                emotionsOfInterest.upload(for: crumbId)
            }
        }
    }
}
