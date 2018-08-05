//
//  IKMotionCharacteristics+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKMotionCharacteristics {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<IKMotionCharacteristics> {
        return NSFetchRequest<IKMotionCharacteristics>(entityName: "IKMotionCharacteristics")
    }

    @NSManaged public var type: String

}
