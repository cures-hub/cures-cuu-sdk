//
//  CUUDocumentPickerViewController.swift
//  CUU
//
//  Created by Lara Marie Reimer on 11.11.18.
//

import UIKit
import ARKit

open class CUUDocumentPickerViewController: UIDocumentPickerViewController {
    override open var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    private  let emotionsKitArSession = ARSession()
    private var emotionsKitFaceDetector: EKFaceDetector?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        emotionsKitSetupTracking()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logViewDidAppearEvent()
        
        // Enable shake gesture detection.
        self.view.becomeFirstResponder()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        logViewDidDisappearEvent()
    }
    
    // Detect shaking
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NoteKit.handleShake()
        }
    }
}


extension CUUDocumentPickerViewController {
    
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

extension CUUDocumentPickerViewController: ARSessionDelegate {
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
