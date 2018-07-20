//
//  IKMotionCharacteristics.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  CUUCharacteristics subclass for handling custom motion data.
 **/
class IKMotionCharacteristics: CUUCharacteristics {
    
    // MARK: - Properties
    
    let interactionType: String = "IKMotion"
    
    let type : String
    
    // MARK: - Lifecycle
    
    init(motion: IKMotion) {
        self.type = motion.type
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case interactionType
        case type
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interactionType, forKey: .interactionType)
        try container.encode(type, forKey: .type)
        
        try super.encode(to: encoder)
    }
}
