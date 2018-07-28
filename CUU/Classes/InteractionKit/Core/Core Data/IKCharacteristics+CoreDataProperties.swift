//
//  IKCharacteristics+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKCharacteristics {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<IKCharacteristics> {
        return NSFetchRequest<IKCharacteristics>(entityName: "IKCharacteristics")
    }
}
