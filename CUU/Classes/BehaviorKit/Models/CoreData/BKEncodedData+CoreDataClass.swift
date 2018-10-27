//
//  BKEncodedData+CoreDataClass.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.10.18.
//
//

import Foundation
import CoreData

@objc(BKEncodedData)
public class BKEncodedData: NSManagedObject, Codable {
    
    convenience init(context: NSManagedObjectContext, situation: BKTransferObject) {
        let entity = NSEntityDescription.entity(forEntityName: "BKEncodedData", in: context)
        
        self.init(entity: entity!, insertInto: context)
        
        self.timestamp = Date()
        
        // Try to serialize situation.
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(situation)
            if let situationString = String(data: data, encoding: String.Encoding.utf8) {
                self.data = situationString
            }
        } catch _ {
            print ("Error serializing situation")
        }
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case data
        case timestamp
    }
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "BKEncodedData", in: managedObjectContext) else {
                fatalError("Failed to decode BKEncodedData")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(String.self, forKey: .data)
        self.timestamp = try container.decode(Date.self, forKey: .timestamp)
    }
    
    // MARK : - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(data, forKey: .data)
        try container.encode(timestamp, forKey: .timestamp)
    }
}
