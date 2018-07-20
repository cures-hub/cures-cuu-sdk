//
//  IKGestureCharacteristics.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  CUUCharacteristics subclass for handling custom gesture data.
 **/
class IKGestureCharacteristics: CUUCharacteristics {
    
    // MARK: - Properties
    
    let interactionType: String = "IKGesture"
    
    let type: String
    
    let touchCount: Int
    let locationX: Double
    let locationY: Double
    
    let scale: Double
    let scaleVelocity: Double
    
    let rotation: Double
    let rotationVelocity: Double
    
    let direction: String
    
    let translationX: Double
    let translationY: Double
    let velocityX: Double
    let velocityY: Double
    
    // MARK: - Lifecycle
    
    init(gesture: IKGesture) {
        self.type = gesture.type
        self.touchCount = gesture.touchCount
        self.locationX = gesture.locationX
        self.locationY = gesture.locationY
        self.scale = gesture.scale
        self.scaleVelocity = gesture.scaleVelocity
        self.rotation = gesture.rotation
        self.rotationVelocity = gesture.rotationVelocity
        self.direction = gesture.direction
        self.translationX = gesture.translationX
        self.translationY = gesture.translationY
        self.velocityX = gesture.velocityX
        self.velocityY = gesture.velocityY
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case interactionType
        case type
        case touchCount
        case locationX
        case locationY
        case scale
        case scaleVelocity
        case rotation
        case rotationVelocity
        case direction
        case translationX
        case translationY
        case velocityX
        case velocityY
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interactionType, forKey: .interactionType)
        try container.encode(type, forKey: .type)
        try container.encode(touchCount, forKey: .touchCount)
        try container.encode(locationX, forKey: .locationX)
        try container.encode(locationY, forKey: .locationY)
        try container.encode(scale, forKey: .scale)
        try container.encode(scaleVelocity, forKey: .scaleVelocity)
        try container.encode(rotation, forKey: .rotation)
        try container.encode(rotationVelocity, forKey: .rotationVelocity)
        try container.encode(direction, forKey: .direction)
        try container.encode(translationX, forKey: .translationX)
        try container.encode(translationY, forKey: .translationY)
        try container.encode(velocityX, forKey: .velocityX)
        try container.encode(velocityY, forKey: .velocityY)
        
        try super.encode(to: encoder)
    }
}
