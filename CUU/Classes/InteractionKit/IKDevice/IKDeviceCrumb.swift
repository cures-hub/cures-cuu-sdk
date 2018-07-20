//
//  IKDeviceCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  IKCrumb subclass for Device Events.
 **/
class IKDeviceCrumb: IKCrumb {
    
    // MARK: - Lifecycle
    
    init(name: String, device: IKDevice) {
        super.init(name: name)
        self.characteristics = IKDeviceCharacteristics(device: device)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
