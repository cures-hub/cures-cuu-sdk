//
//  IKTouchCharacteristics.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  CUUCharacteristics subclass for handling custom touch data.
 **/
class IKTouchCharacteristics: CUUCharacteristics {
    
    // MARK - Properties
    
    let interactionType: String = "IKTouch"
    
    let type: String
    
    let tapCount: Int
    
    let force: Double
    
    let locationX: Double
    let locationY: Double
    let previousLocationX: Double
    let previousLocationY: Double
    
    // MARK - Lifecycle
    
    init(touch: IKTouch) {
        self.type = touch.type
        self.tapCount = touch.tapCount
        self.force = touch.force
        self.locationX = touch.locationX
        self.locationY = touch.locationY
        self.previousLocationX = touch.previousLocationX
        self.previousLocationY = touch.previousLocationY
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case interactionType
        case type
        case tapCount
        case force
        case locationX
        case locationY
        case previousLocationX
        case previousLocationY
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interactionType, forKey: .interactionType)
        try container.encode(type, forKey: .type)
        try container.encode(tapCount, forKey: .tapCount)
        try container.encode(force, forKey: .force)
        try container.encode(locationX, forKey: .locationX)
        try container.encode(locationY, forKey: .locationY)
        try container.encode(previousLocationX, forKey: .previousLocationX)
        try container.encode(previousLocationY, forKey: .previousLocationY)
        
        try super.encode(to: encoder)
    }
}
