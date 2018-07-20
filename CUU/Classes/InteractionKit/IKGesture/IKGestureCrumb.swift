//
//  IKGestureCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  IKCrumb subclass for gestures.
 **/
class IKGestureCrumb: IKCrumb {
    
    // MARK: - Lifecycle
    
    init(name: String, gesture: IKGesture) {
        super.init(name: name)
        self.characteristics = IKGestureCharacteristics(gesture: gesture)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
