//
//  IKViewEventCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

class IKViewEventCrumb: IKCrumb {
    
    // MARK: - Lifecycle
    
    init(name: String, viewEvent: IKViewEvent) {
        super.init(name: name)
        self.characteristics = IKViewEventCharacteristics(viewEvent: viewEvent)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
