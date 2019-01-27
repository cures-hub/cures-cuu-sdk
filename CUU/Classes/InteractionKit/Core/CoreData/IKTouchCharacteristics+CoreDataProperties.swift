//
//  IKTouchCharacteristics+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKTouchCharacteristics {

    @NSManaged public var force: Double
    @NSManaged public var locationX: Double
    @NSManaged public var locationY: Double
    @NSManaged public var previousLocationX: Double
    @NSManaged public var previousLocationY: Double
    @NSManaged public var tapCount: Int16
    @NSManaged public var type: String
    @NSManaged public var touchedElementTraits: String
    @NSManaged public var touchedElementLabel: String
    @NSManaged public var touchedElementValue: String
    @NSManaged public var touchIsPrecise: Bool
}
