//
//  IKAppEventCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.02.18.
//

import Foundation

/**
 *  IKCrumb subclass for App Events.
 **/
public class IKAppEventCrumb: IKCrumb {
    
    // MARK: - Lifecycle
    
    public init(name: String, appEvent: IKAppEvent) {
        super.init(name: name)
        self.characteristics = IKAppEventCharacteristics(appEvent: appEvent)
    }
    
    public required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
