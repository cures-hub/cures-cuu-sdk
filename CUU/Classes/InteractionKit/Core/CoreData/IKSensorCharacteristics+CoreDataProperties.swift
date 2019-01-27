//
//  IKSensorCharacteristics+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKSensorCharacteristics {

    @NSManaged public var type: String
    @NSManaged public var x: Double
    @NSManaged public var y: Double
    @NSManaged public var z: Double

}
