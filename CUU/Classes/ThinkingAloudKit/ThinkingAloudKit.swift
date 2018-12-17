//
//  ThinkingAloud.swift
//  CUU
//
//  Created by Lara Marie Reimer on 17.06.18.
//

import Foundation
import Speech

public class ThinkingAloudKit {
    
    let controller = ThinkingAloudController()
    
    public static var isSupported: Bool {
        guard let _ = CUUConstants.microphoneDescription, let _ = CUUConstants.speechRecognitionDescription, let speechRecognizer = SFSpeechRecognizer() else { return false }
        
        return speechRecognizer.isAvailable
    }
    
    private(set) static var isActive = false
    
    public func start() {
        ThinkingAloudKit.isActive = true
    }
    
    public func stop() {
        ThinkingAloudKit.isActive = false
    }
}
