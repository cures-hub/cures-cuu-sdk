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

    @NSManaged public var title: String
    @NSManaged public var session: String
    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date
    @NSManaged public var user: String
}
