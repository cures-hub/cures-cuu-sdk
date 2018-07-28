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
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKCharacteristics", in: managedObjectContext) else {
                fatalError("Failed to decode IKCharacteristics")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
    }
    
    // MARK : - Encodable
    
    public func encode(to encoder: Encoder) throws {
    }
}
