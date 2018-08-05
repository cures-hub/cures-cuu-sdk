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
        
        self.type = sensor.type
        self.x = sensor.x
        self.y = sensor.y
        self.z = sensor.z
    }

    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
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
        self.type = try container.decode(String.self, forKey: .type)
        self.x = try container.decode(Double.self, forKey: .x)
        self.y = try container.decode(Double.self, forKey: .y)
        self.z = try container.decode(Double.self, forKey: .z)
    }
    
    // MARK : - Encodable
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(z, forKey: .z)
    }
}
