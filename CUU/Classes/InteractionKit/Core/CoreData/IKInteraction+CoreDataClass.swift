//
//  IKInteraction+CoreDataClass.swift
//
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData

@objc(IKInteraction)
public class IKInteraction: NSManagedObject, Codable {
    
    convenience init(context: NSManagedObjectContext, name: String, characteristics: IKCharacteristics) {
        let entity = NSEntityDescription.entity(forEntityName: "IKInteraction", in: context)
        
        self.init(entity: entity!, insertInto: context)
        
        self.name = name
        self.sessionId = CUUSessionManager.sharedManager.currentSession
        self.userId = CUUUserManager.sharedManager.userId
        self.timestamp = Date()
        self.characteristics = ""
        
        // Try to serialize characteristics.
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(characteristics)
            if let characteristicsString = String(data: data, encoding: String.Encoding.utf8) {
                self.characteristics = characteristicsString
            }
        } catch _ {
            print ("Error serializing characteristics")
        }
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case name
        case sessionId
        case userId
        case timestamp
        case characteristics
    }
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKInteraction", in: managedObjectContext) else {
                fatalError("Failed to decode IKInteraction")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.sessionId = try container.decode(String.self, forKey: .sessionId)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
        self.characteristics = try container.decode(String.self, forKey: .characteristics)
    }
    
    // MARK : - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(sessionId, forKey: .sessionId)
        try container.encode(userId, forKey: .userId)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(characteristics, forKey: .characteristics)
    }
}
