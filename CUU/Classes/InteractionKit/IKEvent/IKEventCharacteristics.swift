//
//  IKEventCharacteristics.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  CUUCharacteristics subclass for handling custom event data.
 **/
class IKEventCharacteristics: CUUCharacteristics {
    
    // MARK: - Properties
    
    let interactionType: String = "IKEvent"
    
    let type: String
    let parameter: [String:String]
    
    // MARK: - Lifecycle
    
    init(event: IKEvent) {
        self.type = event.type
        self.parameter = event.parameter
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case interactionType
        case type
        case parameter
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interactionType, forKey: .interactionType)
        try container.encode(type, forKey: .type)
        try container.encode(parameter, forKey: .parameter)
        
        try super.encode(to: encoder)
    }
}
