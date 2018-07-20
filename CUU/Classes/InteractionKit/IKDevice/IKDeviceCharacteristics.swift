//
//  IKDeviceCharacteristics.swift
//  CUU
//
//  Created by Lara Marie Reimer on 11.02.18.
//

import Foundation

/**
 *  CUUCharacteristics subclass for handling custom device data.
 **/
class IKDeviceCharacteristics: CUUCharacteristics {
    
    // MARK: - Properties
    
    var interactionType: String = "IKDevice"
    let startDate: Date
    let endDate: Date
    let title: String
    let commonDeviceName: String
    let deviceName: String
    let deviceModel: String
    let systemName: String
    let systemVersion: String
    let screenSize: Double
    let screenScale: Double
    let screenWidth: Double
    let screenHeight: Double
    let screenNativeWidth: Double
    let screenNativeHeight: Double
    
    // MARK: - Lifecycle
    
    init(device: IKDevice) {
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
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case interactionType
        
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
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interactionType, forKey: .interactionType)
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
        
        try super.encode(to: encoder)
    }
}
