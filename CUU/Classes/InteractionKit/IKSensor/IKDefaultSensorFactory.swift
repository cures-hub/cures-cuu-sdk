import CoreMotion

class IKDefaultSensorFactory: IKSensorFactory {
    
    func sensor(_ capturedDeviceMotion: CMDeviceMotion, type: IKSensorType) -> IKSensor {
        let sensor = IKDefaultSensor()
        return populate(sensor, capturedDeviceMotion: capturedDeviceMotion, ofType: type)
    }
    
}

