import CoreMotion

public protocol IKSensorFactory {
    
    func sensor(_ capturedDeviceMotion: CMDeviceMotion, type: IKSensorType) -> IKSensor

}


extension IKSensorFactory {
    public func populate(_ sensor: IKSensor, capturedDeviceMotion: CMDeviceMotion, ofType type: IKSensorType) -> IKSensor {
        var sensor = sensor
        
        sensor.title = "CMDeviceMotion"
        sensor.type = type.description
        
        switch type {
        case .attitude:
            sensor.x = capturedDeviceMotion.attitude.pitch
            sensor.y = capturedDeviceMotion.attitude.roll
            sensor.z = capturedDeviceMotion.attitude.yaw
        case .rotation:
            sensor.x = capturedDeviceMotion.rotationRate.x
            sensor.y = capturedDeviceMotion.rotationRate.y
            sensor.z = capturedDeviceMotion.rotationRate.z
        case .acceleration:
            sensor.x = capturedDeviceMotion.userAcceleration.x
            sensor.y = capturedDeviceMotion.userAcceleration.y
            sensor.z = capturedDeviceMotion.userAcceleration.z
        case .gravity:
            sensor.x = capturedDeviceMotion.gravity.x
            sensor.y = capturedDeviceMotion.gravity.y
            sensor.z = capturedDeviceMotion.gravity.z
        }
        
        return sensor
    }
    
    func characteristics(from: IKSensor) -> IKSensorCharacteristics {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        return IKSensorCharacteristics(context: context, sensor: from)
    }
    
    func crumb(with characteristics: IKSensorCharacteristics, title: String) -> IKInteraction {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        
        return IKInteraction(context: context,
                             name: "IKSensor :: " + title,
                             characteristics: characteristics)
    }
}
