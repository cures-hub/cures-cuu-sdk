//
//  IKMotionCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  IKCrumb subclass for motions.
 **/
class IKMotionCrumb: IKCrumb {
    // MARK: - Lifecycle
    
    init(name: String, motion: IKMotion) {
        super.init(name: name)
        self.characteristics = IKMotionCharacteristics(motion: motion)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
