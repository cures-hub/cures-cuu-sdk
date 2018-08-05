//
//  IKViewEventCharacteristics+CoreDataClass.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData

@objc(IKViewEventCharacteristics)
public class IKViewEventCharacteristics: IKCharacteristics {

    convenience init(context: NSManagedObjectContext, viewEvent: IKViewEvent) {
        guard let entity = NSEntityDescription.entity(forEntityName: "IKViewEventCharacteristics", in: context) else {
            fatalError("Failed to decode IKViewEventCharacteristics")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.title = viewEvent.title
        self.startDate = viewEvent.startDate
        self.endDate = viewEvent.endDate
        self.session = viewEvent._session
        self.user = viewEvent._user
        self.type = viewEvent.type
        self.viewControllerTitle = viewEvent.viewControllerTitle
        self.viewControllerType = viewEvent.viewControllerType
        self.viewControllerInstance = viewEvent.viewControllerInstance
        self.viewWidth = viewEvent.viewWidth
        self.viewHeight = viewEvent.viewHeight
        self.viewOriginX = viewEvent.viewOriginX
        self.viewOriginY = viewEvent.viewOriginY
        self.globalViewOriginX = viewEvent.globalViewOriginX
        self.globalViewOriginY = viewEvent.globalViewOriginY
        self.subviewCount = Int16(viewEvent.subviewCount)
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case title
        case startDate
        case endDate
        case session
        case user
        case type
        case viewControllerTitle
        case viewControllerType
        case viewControllerInstance
        case viewWidth
        case viewHeight
        case viewOriginX
        case viewOriginY
        case globalViewOriginX
        case globalViewOriginY
        case subviewCount
    }
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKViewEventCharacteristics", in: managedObjectContext) else {
                fatalError("Failed to decode IKViewEventCharacteristics")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        self.session = try container.decode(String.self, forKey: .session)
        self.user = try container.decode(String.self, forKey: .user)
        self.type = try container.decode(String.self, forKey: .type)
        self.viewControllerTitle = try container.decode(String.self, forKey: .viewControllerTitle)
        self.viewControllerType = try container.decode(String.self, forKey: .viewControllerType)
        self.viewControllerInstance = try container.decode(String.self, forKey: .viewControllerInstance)
        self.viewWidth = try container.decode(Double.self, forKey: .viewWidth)
        self.viewHeight = try container.decode(Double.self, forKey: .viewHeight)
        self.viewOriginX = try container.decode(Double.self, forKey: .viewOriginX)
        self.viewOriginY = try container.decode(Double.self, forKey: .viewOriginY)
        self.globalViewOriginX = try container.decode(Double.self, forKey: .globalViewOriginX)
        self.globalViewOriginY = try container.decode(Double.self, forKey: .globalViewOriginY)
        self.subviewCount = try container.decode(Int16.self, forKey: .subviewCount)
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
        try container.encode(viewControllerTitle, forKey: .viewControllerTitle)
        try container.encode(viewControllerType, forKey: .viewControllerType)
        try container.encode(viewControllerInstance, forKey: .viewControllerInstance)
        try container.encode(viewWidth, forKey: .viewWidth)
        try container.encode(viewHeight, forKey: .viewHeight)
        try container.encode(viewOriginX, forKey: .viewOriginX)
        try container.encode(viewOriginY, forKey: .viewOriginY)
        try container.encode(globalViewOriginX, forKey: .globalViewOriginX)
        try container.encode(globalViewOriginY, forKey: .globalViewOriginY)
        try container.encode(subviewCount, forKey: .subviewCount)
    }
    
}
