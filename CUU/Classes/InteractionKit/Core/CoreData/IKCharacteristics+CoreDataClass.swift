//
//  IKCharacteristics+CoreDataClass.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData

@objc(IKCharacteristics)
public class IKCharacteristics: NSManagedObject, Codable {
    
    convenience init(context: NSManagedObjectContext, characteristics: IKDataObject) {
        guard let entity = NSEntityDescription.entity(forEntityName: "IKCharacteristics", in: context) else {
            fatalError("Failed to decode IKCharacteristics")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.title = characteristics.title
        self.startDate = characteristics.startDate
        self.endDate = characteristics.endDate
        self.session = characteristics._session
        self.user = characteristics._user
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case title
        case startDate
        case endDate
        case session
        case user
    }
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKCharacteristics", in: managedObjectContext) else {
                fatalError("Failed to decode IKCharacteristics")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        self.session = try container.decode(String.self, forKey: .session)
        self.user = try container.decode(String.self, forKey: .user)
    }
    
    // MARK : - Encodable
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(session, forKey: .session)
        try container.encode(user, forKey: .user)
    }
}
