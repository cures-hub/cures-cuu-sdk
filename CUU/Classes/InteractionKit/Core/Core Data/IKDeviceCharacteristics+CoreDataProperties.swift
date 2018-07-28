//
//  IKDeviceCharacteristics+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKDeviceCharacteristics {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<IKDeviceCharacteristics> {
        return NSFetchRequest<IKDeviceCharacteristics>(entityName: "IKDeviceCharacteristics")
    }

    @NSManaged public var commonDeviceName: String
    @NSManaged public var deviceModel: String
    @NSManaged public var deviceName: String
    @NSManaged public var endDate: Date
    @NSManaged public var screenHeight: Double
    @NSManaged public var screenNativeHeight: Double
    @NSManaged public var screenNativeWidth: Double
    @NSManaged public var screenScale: Double
    @NSManaged public var screenSize: Double
    @NSManaged public var screenWidth: Double
    @NSManaged public var startDate: Date
    @NSManaged public var systemName: String
    @NSManaged public var systemVersion: String
    @NSManaged public var title: String

}
