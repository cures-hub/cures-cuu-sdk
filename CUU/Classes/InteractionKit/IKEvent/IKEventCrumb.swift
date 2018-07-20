//
//  IKEventCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  IKCrumb subclass for Events.
 **/
class IKEventCrumb: IKCrumb {
    
    // MARK: - Lifecycle
    
    init(name: String, event: IKEvent) {
        super.init(name: name)
        self.characteristics = IKEventCharacteristics(event: event)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
