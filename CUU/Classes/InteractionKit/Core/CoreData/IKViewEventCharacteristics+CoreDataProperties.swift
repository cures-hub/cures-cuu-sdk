//
//  IKViewEventCharacteristics+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKViewEventCharacteristics {

    @NSManaged public var globalViewOriginX: Double
    @NSManaged public var globalViewOriginY: Double
    @NSManaged public var subviewCount: Int16
    @NSManaged public var type: String
    @NSManaged public var viewControllerInstance: String
    @NSManaged public var viewControllerTitle: String
    @NSManaged public var viewControllerType: String
    @NSManaged public var viewHeight: Double
    @NSManaged public var viewOriginX: Double
    @NSManaged public var viewOriginY: Double
    @NSManaged public var viewWidth: Double

}
