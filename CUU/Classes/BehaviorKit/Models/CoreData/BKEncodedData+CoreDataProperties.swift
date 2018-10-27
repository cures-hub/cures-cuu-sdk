//
//  BKEncodedData+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.10.18.
//
//

import Foundation
import CoreData


extension BKEncodedData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BKEncodedData> {
        return NSFetchRequest<BKEncodedData>(entityName: "BKEncodedData")
    }

    @NSManaged public var data: String
    @NSManaged public var timestamp: Date

}
