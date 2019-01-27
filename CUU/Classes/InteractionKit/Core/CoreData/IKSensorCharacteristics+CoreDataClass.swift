//
//  IKSensorCharacteristics+CoreDataClass.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData

@objc(IKSensorCharacteristics)
public class IKSensorCharacteristics: IKCharacteristics {
    
    convenience init(context: NSManagedObjectContext, sensor: IKSensor) {
        guard let entity = NSEntityDescription.entity(forEntityName: "IKSensorCharacteristics", in: context) else {
            fatalError("Failed to decode IKSensorCharacteristics")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.title = sensor.title
        self.startDate = sensor.startDate
        self.endDate = sensor.endDate
        self.session = sensor._session
        self.user = sensor._user
        self.type = sensor.type
        self.x = sensor.x
        self.y = sensor.y
        self.z = sensor.z
    }

    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case title
        case startDate
        case endDate
        case session
        case user
        case type
        case x
        case y
        case z
    }
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKSensorCharacteristics", in: managedObjectContext) else {
                fatalError("Failed to decode IKSensorCharacteristics")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        self.session = try container.decode(String.self, forKey: .session)
        self.user = try container.decode(String.self, forKey: .user)
        self.type = try container.decode(String.self, forKey: .type)
        self.x = try container.decode(Double.self, forKey: .x)
        self.y = try container.decode(Double.self, forKey: .y)
        self.z = try container.decode(Double.self, forKey: .z)
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
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(z, forKey: .z)
    }
}
