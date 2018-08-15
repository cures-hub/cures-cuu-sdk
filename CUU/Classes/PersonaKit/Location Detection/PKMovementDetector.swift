//
//  PKMovementDetector.swift
//  CUU
//
//  Created by Florian Fittschen on 14.08.18.
//

import Foundation
import CoreMotion

class PKMovementDetector {

    private let motionManager = CMMotionManager()
    private let magnetometerUpdateQueue = OperationQueue()

    private var magneticFieldValues: RingBuffer<CMMagneticField> = RingBuffer(count: 10)
    private var threshold = 2.0
    private(set) var moving = false

    deinit {
        stop()
    }

    func start() {
        motionManager.startMagnetometerUpdates(to: magnetometerUpdateQueue) { [unowned self] (magnetometerData, _) in
            guard let magnetometerData = magnetometerData else { return }
            self.magneticFieldValues.write(magnetometerData.magneticField)

            self.moving = self.evaluateMoving(with: magnetometerData.magneticField)
        }
    }

    func stop() {
        motionManager.stopMagnetometerUpdates()
    }

    func evaluateMoving(with currentMagneticField: CMMagneticField) -> Bool {
        guard let oldMagneticField = magneticFieldValues.readItem(numberOfItemsBeforeWriteIndex: 5) else {
            return false
        }

        let difference = abs(oldMagneticField - currentMagneticField)
        let maximumDifference = max(difference.x, difference.y, difference.z)

        return maximumDifference > threshold
    }

}

private func -(left: CMMagneticField, right: CMMagneticField) -> CMMagneticField {
    return CMMagneticField(x: left.x - right.x,
                           y: left.y - right.y,
                           z: left.z - right.z)
}

private func +(left: CMMagneticField, right: CMMagneticField) -> CMMagneticField {
    return CMMagneticField(x: left.x + right.x,
                           y: left.y + right.y,
                           z: left.z + right.z)
}

private func abs(_ magneticField: CMMagneticField) -> CMMagneticField {
    return CMMagneticField(x: abs(magneticField.x),
                           y: abs(magneticField.y),
                           z: abs(magneticField.z))
}

