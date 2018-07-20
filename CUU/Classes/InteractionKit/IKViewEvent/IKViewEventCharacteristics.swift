//
//  IKViewEventCharacteristics.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

class IKViewEventCharacteristics: CUUCharacteristics {
    
    // MARK: - Properties
    
    let interactionType: String = "IKViewEvent"
    
    let type: String
    let viewControllerTitle: String
    let viewControllerType: String
    let viewControllerInstance: String
    
    let viewWidth: Double
    let viewHeight: Double
    let viewOriginX: Double
    let viewOriginY: Double
    let globalViewOriginX: Double
    let globalViewOriginY: Double
    
    let subviewCount: Int
    
    // MARK: - Lifecycle
    
    init(viewEvent: IKViewEvent) {
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
        self.subviewCount = viewEvent.subviewCount
        
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    // MARK: - Serialization
    
    private enum CodingKeys: String, CodingKey {
        case interactionType
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
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(interactionType, forKey: .interactionType)
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
        
        try super.encode(to: encoder)
    }
}
