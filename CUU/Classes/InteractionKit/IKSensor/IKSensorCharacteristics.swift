//
//  IKSensorCharacteristics.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  CUUCharacteristics subclass for handling custom sensor data.
 **/
class IKSensorCharacteristics: CUUCharacteristics {
    
    // MARK: - Properties
    
    let interactionType: String = "IKSensor"
    
    let type : String
    
    let x: Double
    let y: Double
    let z: Double
    
    // MARK: - Lifecycle
    
    init(sensor: IKSensor) {
        self.type = sensor.type
        self.x = sensor.x
        self.y = sensor.y
        self.z = sensor.z
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case interactionType
        case type
        case x
        case y
        case z
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interactionType, forKey: .interactionType)
        try container.encode(type, forKey: .type)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(z, forKey: .z)
        
        try super.encode(to: encoder)
    }
}
