//
//  IKEventCharacteristics+CoreDataClass.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData

@objc(IKEventCharacteristics)
public class IKEventCharacteristics: IKCharacteristics {

    convenience init(context: NSManagedObjectContext, event: IKEvent) {
        guard let entity = NSEntityDescription.entity(forEntityName: "IKEventCharacteristics", in: context) else {
            fatalError("Failed to decode IKEventCharacteristics")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.title = event.title
        self.startDate = event.startDate
        self.endDate = event.endDate
        self.session = event._session
        self.user = event._user
        self.type = event.type
        self.parameter = ""
        
        // Try to serialize characteristics.
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(parameter)
            if let parameterString = String(data: data, encoding: String.Encoding.utf8) {
                self.parameter = parameterString
            }
        } catch _ {
            print ("Error serializing characteristics")
        }
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case title
        case startDate
        case endDate
        case session
        case user
        case type
        case parameter
    }
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKEventCharacteristics", in: managedObjectContext) else {
                fatalError("Failed to decode IKEventCharacteristics")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        self.session = try container.decode(String.self, forKey: .session)
        self.user = try container.decode(String.self, forKey: .user)
        self.type = try container.decode(String.self, forKey: .type)
        self.parameter = try container.decode(String.self, forKey: .parameter)
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
        try container.encode(parameter, forKey: .parameter)
    }
}
