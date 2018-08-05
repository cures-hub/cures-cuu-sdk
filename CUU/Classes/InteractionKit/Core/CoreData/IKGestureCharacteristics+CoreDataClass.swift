//
//  IKGestureCharacteristics+CoreDataClass.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData

@objc(IKGestureCharacteristics)
public class IKGestureCharacteristics: IKCharacteristics {
    
    convenience init(context: NSManagedObjectContext, gesture: IKGesture) {
        guard let entity = NSEntityDescription.entity(forEntityName: "IKGestureCharacteristics", in: context) else {
                fatalError("Failed to decode IKGestureCharacteristics")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.type = gesture.type
        self.touchCount = Int16(gesture.touchCount)
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
    }

    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
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
    
    // MARK: - Decodable
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKGestureCharacteristics", in: managedObjectContext) else {
                fatalError("Failed to decode IKGestureCharacteristics")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.touchCount = try container.decode(Int16.self, forKey: .touchCount)
        self.locationX = try container.decode(Double.self, forKey: .locationX)
        self.locationY = try container.decode(Double.self, forKey: .locationY)
        self.scale = try container.decode(Double.self, forKey: .scale)
        self.scaleVelocity = try container.decode(Double.self, forKey: .scaleVelocity)
        self.rotation = try container.decode(Double.self, forKey: .rotation)
        self.rotationVelocity = try container.decode(Double.self, forKey: .rotationVelocity)
        self.direction = try container.decode(String.self, forKey: .direction)
        self.translationX = try container.decode(Double.self, forKey: .translationX)
        self.translationY = try container.decode(Double.self, forKey: .translationY)
        self.velocityX = try container.decode(Double.self, forKey: .velocityX)
        self.velocityY = try container.decode(Double.self, forKey: .velocityY)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
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
    }
}
