//
//  IKEventCharacteristics+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKEventCharacteristics {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<IKEventCharacteristics> {
        return NSFetchRequest<IKEventCharacteristics>(entityName: "IKEventCharacteristics")
    }

    @NSManaged public var parameter: String
    @NSManaged public var type: String

}
