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
        
        self.title = touch.title
        self.startDate = touch.startDate
        self.endDate = touch.endDate
        self.session = touch._session
        self.user = touch._user
        self.type = touch.type
        self.tapCount = Int16(touch.tapCount)
        self.force = touch.force
        self.locationX = touch.locationX
        self.locationY = touch.locationY
        self.previousLocationX = touch.previousLocationX
        self.previousLocationY = touch.previousLocationY
        self.touchedElementTraits = touch.touchedElementTraits
        self.touchedElementLabel = touch.touchedElementLabel
        self.touchedElementValue = touch.touchedElementValue
        self.touchIsPrecise = touch.touchIsPrecise
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case title
        case startDate
        case endDate
        case session
        case user
        case type
        case tapCount
        case force
        case locationX
        case locationY
        case previousLocationX
        case previousLocationY
        case touchedElementTraits
        case touchedElementLabel
        case touchedElementValue
        case touchIsPrecise
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
        self.title = try container.decode(String.self, forKey: .title)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        self.session = try container.decode(String.self, forKey: .session)
        self.user = try container.decode(String.self, forKey: .user)
        self.type = try container.decode(String.self, forKey: .type)
        self.tapCount = try container.decode(Int16.self, forKey: .tapCount)
        self.force = try container.decode(Double.self, forKey: .force)
        self.locationX = try container.decode(Double.self, forKey: .locationX)
        self.locationY = try container.decode(Double.self, forKey: .locationY)
        self.previousLocationX = try container.decode(Double.self, forKey: .previousLocationX)
        self.previousLocationY = try container.decode(Double.self, forKey: .previousLocationY)
        self.touchedElementTraits = try container.decode(String.self, forKey: .touchedElementTraits)
        self.touchedElementLabel = try container.decode(String.self, forKey: .touchedElementLabel)
        self.touchedElementValue = try container.decode(String.self, forKey: .touchedElementValue)
        self.touchIsPrecise = try container.decode(Bool.self, forKey: .touchIsPrecise)
    }
    
    // MARK : - Encodable
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(session, forKey: .session)
        try container.encode(user, forKey: .user)
        try container.encode(type, forKey: .type)
        try container.encode(tapCount, forKey: .tapCount)
        try container.encode(force, forKey: .force)
        try container.encode(locationX, forKey: .locationX)
        try container.encode(locationY, forKey: .locationY)
        try container.encode(previousLocationX, forKey: .previousLocationX)
        try container.encode(previousLocationY, forKey: .previousLocationY)
        try container.encode(touchedElementTraits, forKey: .touchedElementTraits)
        try container.encode(touchedElementLabel, forKey: .touchedElementLabel)
        try container.encode(touchedElementValue, forKey: .touchedElementValue)
        try container.encode(touchIsPrecise, forKey: .touchIsPrecise)
    }
}
