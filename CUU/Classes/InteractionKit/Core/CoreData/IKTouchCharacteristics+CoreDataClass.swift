//
//  IKTouchCharacteristics+CoreDataClass.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData

@objc(IKTouchCharacteristics)
public class IKTouchCharacteristics: IKCharacteristics {

    convenience init(context: NSManagedObjectContext, touch: IKTouch) {
        guard let entity = NSEntityDescription.entity(forEntityName: "IKTouchCharacteristics", in: context) else {
            fatalError("Failed to decode IKTouchCharacteristics")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.type = touch.type
        self.tapCount = Int16(touch.tapCount)
        self.force = touch.force
        self.locationX = touch.locationX
        self.locationY = touch.locationY
        self.previousLocationX = touch.previousLocationX
        self.previousLocationY = touch.previousLocationY
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case type
        case tapCount
        case force
        case locationX
        case locationY
        case previousLocationX
        case previousLocationY
    }
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKTouchCharacteristics", in: managedObjectContext) else {
                fatalError("Failed to decode IKTouchCharacteristics")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.tapCount = try container.decode(Int16.self, forKey: .tapCount)
        self.force = try container.decode(Double.self, forKey: .force)
        self.locationX = try container.decode(Double.self, forKey: .locationX)
        self.locationY = try container.decode(Double.self, forKey: .locationY)
        self.previousLocationX = try container.decode(Double.self, forKey: .previousLocationX)
        self.previousLocationY = try container.decode(Double.self, forKey: .previousLocationY)
    }
    
    // MARK : - Encodable
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(tapCount, forKey: .tapCount)
        try container.encode(force, forKey: .force)
        try container.encode(locationX, forKey: .locationX)
        try container.encode(locationY, forKey: .locationY)
        try container.encode(previousLocationX, forKey: .previousLocationX)
        try container.encode(previousLocationY, forKey: .previousLocationY)
    }
}
