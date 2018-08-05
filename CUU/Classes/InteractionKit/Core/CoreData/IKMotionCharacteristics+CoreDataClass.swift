//
//  IKMotionCharacteristics+CoreDataClass.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData

@objc(IKMotionCharacteristics)
public class IKMotionCharacteristics: IKCharacteristics {
    
    convenience init(context: NSManagedObjectContext, motion: IKMotion) {
        guard let entity = NSEntityDescription.entity(forEntityName: "IKMotionCharacteristics", in: context) else {
            fatalError("Failed to decode IKMotionCharacteristics")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.type = motion.type
    }

    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case type
    }
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKMotionCharacteristics", in: managedObjectContext) else {
                fatalError("Failed to decode IKMotionCharacteristics")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
    }
    
    // MARK : - Encodable
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
    }
}
