class BKAgeGroupFeatureGenerator {
    
    func features(completion: (AgeGroupContextInput?)->Void ) {
        
        let lock = NSLock()
        var openTasks = 2
        
        let windowSize: TimeInterval = 60
        let predicate = NSPredicate(format: "startDate > %@", Date(timeIntervalSinceNow: -windowSize) as CVarArg)
        
        
        var numberOfMotionShakes: Double = 0
        var attitudeAverageX: Double = 0
        var attitudeAveragey: Double = 0
        var attitudeAverageZ: Double = 0
        var attitudeAbsoluteAverageX: Double = 0
        var attitudeAbsoluteAveragey: Double = 0
        var attitudeAbsoluteAverageZ: Double = 0
        var attitudeMaxX: Double = 0
        var attitudeMaxy: Double = 0
        var attitudeMaxZ: Double = 0
        var attitudeMinX: Double = 0
        var attitudeMiny: Double = 0
        var attitudeMinZ: Double = 0
        var attitudeVarianceX: Double = 0
        var attitudeVariancey: Double = 0
        var attitudeVarianceZ: Double = 0
        var rotationAverageX: Double = 0
        var rotationAveragey: Double = 0
        var rotationAverageZ: Double = 0
        var rotationAbsoluteAverageX: Double = 0
        var rotationAbsoluteAveragey: Double = 0
        var rotationAbsoluteAverageZ: Double = 0
        var rotationMaxX: Double = 0
        var rotationMaxy: Double = 0
        var rotationMaxZ: Double = 0
        var rotationMinX: Double = 0
        var rotationMiny: Double = 0
        var rotationMinZ: Double = 0
        var rotationVarianceX: Double = 0
        var rotationVariancey: Double = 0
        var rotationVarianceZ: Double = 0
        var accelerationAverageX: Double = 0
        var accelerationAveragey: Double = 0
        var accelerationAverageZ: Double = 0
        var accelerationAbsoluteAverageX: Double = 0
        var accelerationAbsoluteAveragey: Double = 0
        var accelerationAbsoluteAverageZ: Double = 0
        var accelerationMaxX: Double = 0
        var accelerationMaxy: Double = 0
        var accelerationMaxZ: Double = 0
        var accelerationMinX: Double = 0
        var accelerationMiny: Double = 0
        var accelerationMinZ: Double = 0
        var accelerationVarianceX: Double = 0
        var accelerationVariancey: Double = 0
        var accelerationVarianceZ: Double = 0
        
        // UKSensor
        InteractionKit.shared.fetch(IKSensorCharacteristics.self, predicate: predicate, completion: { results in
            
            if let sensorValues = results as? Array<IKSensorCharacteristics> {
                
                var attitudeX: [Double] = []
                var attitudeY: [Double] = []
                var attitudeZ: [Double] = []
                var rotationX: [Double] = []
                var rotationY: [Double] = []
                var rotationZ: [Double] = []
                var accelerationX: [Double] = []
                var accelerationY: [Double] = []
                var accelerationZ: [Double] = []
                
                var absoluteAttitudeX: [Double] = []
                var absoluteAttitudeY: [Double] = []
                var absoluteAttitudeZ: [Double] = []
                var absoluteRotationX: [Double] = []
                var absoluteRotationY: [Double] = []
                var absoluteRotationZ: [Double] = []
                var absoluteAccelerationX: [Double] = []
                var absoluteAccelerationY: [Double] = []
                var absoluteAccelerationZ: [Double] = []
                
                for sensorValue in sensorValues {
                    if sensorValue.type == "attitude" {
                        attitudeX.append(sensorValue.x)
                        attitudeY.append(sensorValue.y)
                        attitudeZ.append(sensorValue.z)
                        absoluteAttitudeX.append(abs(sensorValue.x))
                        absoluteAttitudeY.append(abs(sensorValue.y))
                        absoluteAttitudeZ.append(abs(sensorValue.z))
                    } else if sensorValue.type == "rotation" {
                        rotationX.append(sensorValue.x)
                        rotationY.append(sensorValue.y)
                        rotationZ.append(sensorValue.z)
                        absoluteRotationX.append(abs(sensorValue.x))
                        absoluteRotationY.append(abs(sensorValue.y))
                        absoluteRotationZ.append(abs(sensorValue.z))
                    } else if sensorValue.type == "acceleration" {
                        accelerationX.append(sensorValue.x)
                        accelerationY.append(sensorValue.y)
                        accelerationZ.append(sensorValue.z)
                        absoluteAccelerationX.append(abs(sensorValue.x))
                        absoluteAccelerationY.append(abs(sensorValue.y))
                        absoluteAccelerationZ.append(abs(sensorValue.z))
                    }
                }
                
                attitudeAverageX = Sigma.average(attitudeX) ?? 0
                attitudeAveragey =  Sigma.average(attitudeY) ?? 0
                attitudeAverageZ = Sigma.average(attitudeZ) ?? 0
                attitudeAbsoluteAverageX = Sigma.average(absoluteAttitudeX) ?? 0
                attitudeAbsoluteAveragey = Sigma.average(absoluteAttitudeY) ?? 0
                attitudeAbsoluteAverageZ = Sigma.average(absoluteAttitudeZ) ?? 0
                attitudeMaxX = Sigma.max(attitudeX) ?? 0
                attitudeMaxy = Sigma.max(attitudeY) ?? 0
                attitudeMaxZ = Sigma.max(attitudeZ) ?? 0
                attitudeMinX = Sigma.min(attitudeX) ?? 0
                attitudeMiny = Sigma.min(attitudeY) ?? 0
                attitudeMinZ = Sigma.min(attitudeZ) ?? 0
                attitudeVarianceX = Sigma.varianceSample(attitudeX) ?? 00
                attitudeVariancey = Sigma.varianceSample(attitudeY) ?? 00
                attitudeVarianceZ = Sigma.varianceSample(attitudeZ) ?? 00
                rotationAverageX = Sigma.average(rotationX) ?? 0
                rotationAveragey =  Sigma.average(rotationY) ?? 0
                rotationAverageZ = Sigma.average(rotationZ) ?? 0
                rotationAbsoluteAverageX = Sigma.average(absoluteRotationX) ?? 0
                rotationAbsoluteAveragey = Sigma.average(absoluteRotationY) ?? 0
                rotationAbsoluteAverageZ = Sigma.average(absoluteRotationZ) ?? 0
                rotationMaxX = Sigma.max(rotationX) ?? 0
                rotationMaxy = Sigma.max(rotationY) ?? 0
                rotationMaxZ = Sigma.max(rotationZ) ?? 0
                rotationMinX = Sigma.min(rotationX) ?? 0
                rotationMiny = Sigma.min(rotationY) ?? 0
                rotationMinZ = Sigma.min(rotationZ) ?? 0
                rotationVarianceX = Sigma.varianceSample(rotationX) ?? 00
                rotationVariancey = Sigma.varianceSample(rotationY) ?? 00
                rotationVarianceZ = Sigma.varianceSample(rotationZ) ?? 00
                accelerationAverageX = Sigma.average(accelerationX) ?? 0
                accelerationAveragey =  Sigma.average(accelerationY) ?? 0
                accelerationAverageZ = Sigma.average(accelerationZ) ?? 0
                accelerationAbsoluteAverageX = Sigma.average(absoluteAccelerationX) ?? 0
                accelerationAbsoluteAveragey = Sigma.average(absoluteAccelerationY) ?? 0
                accelerationAbsoluteAverageZ = Sigma.average(absoluteAccelerationZ) ?? 0
                accelerationMaxX = Sigma.max(accelerationX) ?? 0
                accelerationMaxy = Sigma.max(accelerationY) ?? 0
                accelerationMaxZ = Sigma.max(accelerationZ) ?? 0
                accelerationMinX = Sigma.min(accelerationX) ?? 0
                accelerationMiny = Sigma.min(accelerationY) ?? 0
                accelerationMinZ = Sigma.min(accelerationZ) ?? 0
                accelerationVarianceX = Sigma.varianceSample(accelerationX) ?? 00
                accelerationVariancey = Sigma.varianceSample(accelerationY) ?? 00
                accelerationVarianceZ = Sigma.varianceSample(accelerationZ) ?? 00
            
                
                lock.lock()
                openTasks -= 1
                if openTasks == 0 {
                    return completion(AgeGroupContextInput(
                        numberOfMotionShakes: numberOfMotionShakes,
                        attitudeAverageX: attitudeAverageX,
                        attitudeAveragey: attitudeAveragey,
                        attitudeAverageZ: attitudeAverageZ,
                        attitudeAbsoluteAverageX: attitudeAbsoluteAverageX,
                        attitudeAbsoluteAveragey: attitudeAbsoluteAveragey,
                        attitudeAbsoluteAverageZ: attitudeAbsoluteAverageZ,
                        attitudeMaxX: attitudeMaxX,
                        attitudeMaxy: attitudeMaxy,
                        attitudeMaxZ: attitudeMaxZ,
                        attitudeMinX: attitudeMinX,
                        attitudeMiny: attitudeMiny,
                        attitudeMinZ: attitudeMinZ,
                        attitudeVarianceX: attitudeVarianceX,
                        attitudeVariancey: attitudeVariancey,
                        attitudeVarianceZ: attitudeVarianceZ,
                        rotationAverageX: rotationAverageX,
                        rotationAveragey: rotationAveragey,
                        rotationAverageZ: rotationAverageZ,
                        rotationAbsoluteAverageX: rotationAbsoluteAverageX,
                        rotationAbsoluteAveragey: rotationAbsoluteAveragey,
                        rotationAbsoluteAverageZ: rotationAbsoluteAverageZ,
                        rotationMaxX: rotationMaxX,
                        rotationMaxy: rotationMaxy,
                        rotationMaxZ: rotationMaxZ,
                        rotationMinX: rotationMinX,
                        rotationMiny: rotationMiny,
                        rotationMinZ: rotationMinZ,
                        rotationVarianceX: rotationVarianceX,
                        rotationVariancey: rotationVariancey,
                        rotationVarianceZ: rotationVarianceZ,
                        accelerationAverageX: accelerationAverageX,
                        accelerationAveragey: accelerationAveragey,
                        accelerationAverageZ: accelerationAverageZ,
                        accelerationAbsoluteAverageX: accelerationAbsoluteAverageX,
                        accelerationAbsoluteAveragey: accelerationAbsoluteAveragey,
                        accelerationAbsoluteAverageZ: accelerationAbsoluteAverageZ,
                        accelerationMaxX: accelerationMaxX,
                        accelerationMaxy: accelerationMaxy,
                        accelerationMaxZ: accelerationMaxZ,
                        accelerationMinX: accelerationMinX,
                        accelerationMiny: accelerationMiny,
                        accelerationMinZ: accelerationMinZ,
                        accelerationVarianceX: accelerationVarianceX,
                        accelerationVariancey: accelerationVariancey,
                        accelerationVarianceZ: accelerationVarianceZ
                    ))
                }
                lock.unlock()
                
            }
        })
        
        
        // UKMotions
        InteractionKit.shared.fetch(IKMotionCharacteristics.self, predicate: predicate, completion: { results in
            
            if let motionShakes = results as? Array<IKMotionCharacteristics> {
                
                // TODO get UKMotions
                
                numberOfMotionShakes = Double(motionShakes.count)
                
                lock.lock()
                openTasks -= 1
                if openTasks == 0 {
                    if #available(iOS 11.0, *) {
                        return completion(AgeGroupContextInput(
                            numberOfMotionShakes: numberOfMotionShakes,
                            attitudeAverageX: attitudeAverageX,
                            attitudeAveragey: attitudeAveragey,
                            attitudeAverageZ: attitudeAverageZ,
                            attitudeAbsoluteAverageX: attitudeAbsoluteAverageX,
                            attitudeAbsoluteAveragey: attitudeAbsoluteAveragey,
                            attitudeAbsoluteAverageZ: attitudeAbsoluteAverageZ,
                            attitudeMaxX: attitudeMaxX,
                            attitudeMaxy: attitudeMaxy,
                            attitudeMaxZ: attitudeMaxZ,
                            attitudeMinX: attitudeMinX,
                            attitudeMiny: attitudeMiny,
                            attitudeMinZ: attitudeMinZ,
                            attitudeVarianceX: attitudeVarianceX,
                            attitudeVariancey: attitudeVariancey,
                            attitudeVarianceZ: attitudeVarianceZ,
                            rotationAverageX: rotationAverageX,
                            rotationAveragey: rotationAveragey,
                            rotationAverageZ: rotationAverageZ,
                            rotationAbsoluteAverageX: rotationAbsoluteAverageX,
                            rotationAbsoluteAveragey: rotationAbsoluteAveragey,
                            rotationAbsoluteAverageZ: rotationAbsoluteAverageZ,
                            rotationMaxX: rotationMaxX,
                            rotationMaxy: rotationMaxy,
                            rotationMaxZ: rotationMaxZ,
                            rotationMinX: rotationMinX,
                            rotationMiny: rotationMiny,
                            rotationMinZ: rotationMinZ,
                            rotationVarianceX: rotationVarianceX,
                            rotationVariancey: rotationVariancey,
                            rotationVarianceZ: rotationVarianceZ,
                            accelerationAverageX: accelerationAverageX,
                            accelerationAveragey: accelerationAveragey,
                            accelerationAverageZ: accelerationAverageZ,
                            accelerationAbsoluteAverageX: accelerationAbsoluteAverageX,
                            accelerationAbsoluteAveragey: accelerationAbsoluteAveragey,
                            accelerationAbsoluteAverageZ: accelerationAbsoluteAverageZ,
                            accelerationMaxX: accelerationMaxX,
                            accelerationMaxy: accelerationMaxy,
                            accelerationMaxZ: accelerationMaxZ,
                            accelerationMinX: accelerationMinX,
                            accelerationMiny: accelerationMiny,
                            accelerationMinZ: accelerationMinZ,
                            accelerationVarianceX: accelerationVarianceX,
                            accelerationVariancey: accelerationVariancey,
                            accelerationVarianceZ: accelerationVarianceZ
                        ))
                    } else {
                        // Fallback on earlier versions
                    }
                }
                lock.unlock()
            }
        })
        
    }
    
    
}

