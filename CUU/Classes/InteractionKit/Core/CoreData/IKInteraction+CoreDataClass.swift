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
public class IKInteraction: NSManagedObject, Encodable {
    
    init(context: NSManagedObjectContext, name: String, characteristics: IKCharacteristics) {
        let entity = NSEntityDescription.entity(forEntityName: "IKInteraction", in: context)
        super.init(entity: entity!, insertInto: context)
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
}
