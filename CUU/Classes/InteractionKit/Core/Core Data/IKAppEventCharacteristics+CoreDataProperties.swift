//
//  IKAppEventCharacteristics+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKAppEventCharacteristics {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<IKAppEventCharacteristics> {
        return NSFetchRequest<IKAppEventCharacteristics>(entityName: "IKAppEventCharacteristics")
    }

    // MARK: - Properties
    @NSManaged public var type: String
    
}
