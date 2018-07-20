//
//  IKTouchCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  IKCrumb subclass for touch data.
 **/
class IKTouchCrumb: IKCrumb {
    
    // MARK - Lifecycle
    
    init(name: String, touch: IKTouch) {
        super.init(name: name)
        self.characteristics = IKTouchCharacteristics(touch: touch)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
