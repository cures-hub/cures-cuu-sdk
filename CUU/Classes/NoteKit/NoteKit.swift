//
//  NoteKit.swift
//  CUU
//
//  Created by Lara Marie Reimer on 22.09.18.
//

import Foundation

/**
 *  Open class to exhibit NoteKit behavior.
 **/
open class NoteKit {
    
    static var isActive = false
    
    /*
     *   Starts noteKit.
     */
    static func start() {
        NoteKit.isActive = true
    }
    
    /*
     *   Stops noteKit.
     */
    static func stop() {
        NoteKit.isActive = false
    }
    
    static func handleShake() {
        if NoteKit.isActive {
            NKFeedbackController.promptForFeedback()
        }
    }
}
