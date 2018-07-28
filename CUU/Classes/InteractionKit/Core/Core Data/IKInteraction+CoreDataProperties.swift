//
//  IKInteraction+CoreDataProperties.swift
//  
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKInteraction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IKInteraction> {
        return NSFetchRequest<IKInteraction>(entityName: "IKInteraction")
    }

    @NSManaged public var userId: String?
    @NSManaged public var timestamp: NSDate?
    @NSManaged public var sessionId: String?
    @NSManaged public var name: String?
    @NSManaged public var characteristics: String?

}
