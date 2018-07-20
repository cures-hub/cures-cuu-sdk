//
//  IKSensorCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  IKCrumb subclass for sensor data.
 **/
class IKSensorCrumb: IKCrumb {
    
    // MARK: - Lifecycle
    
    init(name: String, sensor: IKSensor) {
        super.init(name: name)
        self.characteristics = IKSensorCharacteristics(sensor: sensor)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
