//
//  IKGestureCharacteristics+CoreDataProperties.swift
//  CUU
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKGestureCharacteristics {

    @NSManaged public var direction: String
    @NSManaged public var locationX: Double
    @NSManaged public var locationY: Double
    @NSManaged public var rotation: Double
    @NSManaged public var rotationVelocity: Double
    @NSManaged public var scale: Double
    @NSManaged public var scaleVelocity: Double
    @NSManaged public var touchCount: Int16
    @NSManaged public var translationX: Double
    @NSManaged public var translationY: Double
    @NSManaged public var type: String
    @NSManaged public var velocityX: Double
    @NSManaged public var velocityY: Double

}
