//
//  IKDefaultCharacteristics.swift
//  CUU
//
//  Created by Lara Marie Reimer on 08.02.18.
//

import Foundation

/**
 *  CUUCharacteristics subclass for handling custom InteractionKit data.
 **/
public class IKDefaultCharacteristics: CUUCharacteristics {
    
    // MARK: - Properties
    
    public let interactionType: String = "interactionCrumb"

    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case interactionType
    }
        
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interactionType, forKey: .interactionType)
        
        try super.encode(to: encoder)
    }
}
