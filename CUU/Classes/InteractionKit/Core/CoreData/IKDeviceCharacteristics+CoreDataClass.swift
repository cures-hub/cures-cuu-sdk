//
//  IKDeviceCharacteristics+CoreDataClass.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData

@objc(IKDeviceCharacteristics)
public class IKDeviceCharacteristics: IKCharacteristics {

    convenience init(context: NSManagedObjectContext, device: IKDevice) {
        guard let entity = NSEntityDescription.entity(forEntityName: "IKDeviceCharacteristics", in: context) else {
            fatalError("Failed to decode IKDeviceCharacteristics")
        }
        
        self.init(entity: entity, insertInto: context)
        
        self.startDate = device.startDate
        self.endDate = device.endDate
        self.title = device.title
        self.commonDeviceName = device.commonDeviceName
        self.deviceName = device.deviceName
        self.deviceModel = device.deviceModel
        self.systemName = device.systemName
        self.systemVersion = device.systemVersion
        self.screenSize = device.screenSize
        self.screenScale = device.screenScale
        self.screenWidth = device.screenWidth
        self.screenHeight = device.screenHeight
        self.screenNativeWidth = device.screenNativeWidth
        self.screenNativeHeight = device.screenNativeHeight
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case startDate
        case endDate
        case title
        case commonDeviceName
        case deviceName
        case deviceModel
        case systemName
        case systemVersion
        case screenSize
        case screenScale
        case screenWidth
        case screenHeight
        case screenNativeWidth
        case screenNativeHeight
    }
    
    // MARK: - Decodable
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext"),
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "IKDeviceCharacteristics", in: managedObjectContext) else {
                fatalError("Failed to decode IKDeviceCharacteristics")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        self.title = try container.decode(String.self, forKey: .title)
        self.commonDeviceName = try container.decode(String.self, forKey: .commonDeviceName)
        self.deviceName = try container.decode(String.self, forKey: .deviceName)
        self.deviceModel = try container.decode(String.self, forKey: .deviceModel)
        self.systemName = try container.decode(String.self, forKey: .systemName)
        self.systemVersion = try container.decode(String.self, forKey: .systemVersion)
        self.screenSize = try container.decode(Double.self, forKey: .screenSize)
        self.screenScale = try container.decode(Double.self, forKey: .screenScale)
        self.screenWidth = try container.decode(Double.self, forKey: .screenWidth)
        self.screenHeight = try container.decode(Double.self, forKey: .screenHeight)
        self.screenNativeWidth = try container.decode(Double.self, forKey: .screenNativeWidth)
        self.screenNativeHeight = try container.decode(Double.self, forKey: .screenNativeHeight)
    }
    
    // MARK : - Encodable
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(title, forKey: .title)
        try container.encode(commonDeviceName, forKey: .commonDeviceName)
        try container.encode(deviceName, forKey: .deviceName)
        try container.encode(deviceModel, forKey: .deviceModel)
        try container.encode(systemName, forKey: .systemName)
        try container.encode(systemVersion, forKey: .systemVersion)
        try container.encode(screenScale, forKey: .screenScale)
        try container.encode(screenWidth, forKey: .screenWidth)
        try container.encode(screenHeight, forKey: .screenHeight)
        try container.encode(screenNativeWidth, forKey: .screenNativeWidth)
        try container.encode(screenNativeHeight, forKey: .screenNativeHeight)
    }
}
