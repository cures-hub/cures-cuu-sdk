//
//  EmotionsKitViewController.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.12.17.
//

import ARKit

open class EKViewController: UIViewController {

    private  let emotionsKitArSession = ARSession()
    private var emotionsKitFaceDetector: EKFaceDetector?

    override open func viewDidLoad() {
        super.viewDidLoad()
        emotionsKitSetupTracking()
    }
}

extension EKViewController {

    private func emotionsKitSetupTracking() {
        emotionsKitArSession.delegate = self
        emotionsKitResetTracking()
        emotionsKitFaceDetector = EKFaceDetectorFactory.instance
    }

    private func emotionsKitResetTracking() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        emotionsKitArSession.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

}

extension EKViewController: ARSessionDelegate {
    public func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        emotionsKitFaceDetector?.detectFace(from: anchors)
    }

    public func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }

        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]

        print(messages.compactMap({ $0 }).joined(separator: "\n"))
    }

    public func sessionWasInterrupted(_ session: ARSession) {
        print("""
        SESSION INTERRUPTED
        The session will be reset after the interruption has ended.
        """)
    }

    public func sessionInterruptionEnded(_ session: ARSession) {
        DispatchQueue.main.async {
            self.emotionsKitResetTracking()
        }
    }
}
