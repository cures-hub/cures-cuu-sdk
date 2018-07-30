//
//  IKAppEventCharacteristics.swift
//  CUU
//
//  Created by Lara Marie Reimer on 11.02.18.
//

import Foundation

/**
 *  CUUCharacteristics subclass for handling custom app event data.
 **/
class IKAppEventCharacteristics: CUUCharacteristics {
    
    // MARK: - Properties
    let interactionType: String
    
    let type: String = "IKAppEvent"
    
    // MARK: - Lifecycle
    
    init(appEvent: IKAppEvent) {
        self.interactionType = appEvent.title
        
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
