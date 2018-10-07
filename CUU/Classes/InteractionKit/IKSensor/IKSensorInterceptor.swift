import CoreMotion

@available(iOS 10.0, *)
public class IKSensorInterceptor: IKInterceptor  {
    
    // MARK: - Properties
    
    private var isActive: Bool = false
    private var timer: Timer?
    private var motion: CMMotionManager
    
    public var interceptionDelegate: IKInterceptionDelegate
    public var sensorFactory: IKSensorFactory
    public var sensorTypes: [IKSensorType]
    public var updateFrequency: TimeInterval
    
    // MARK: - Lifecycle
    
    init(interceptionDelegate: IKInterceptionDelegate,
         sensorFactory: IKSensorFactory,
         sensorTypes: [IKSensorType],
         updateFrequency: TimeInterval = 1.0) {
        
        self.interceptionDelegate = interceptionDelegate
        self.sensorFactory = sensorFactory
        self.sensorTypes = sensorTypes
        self.updateFrequency = updateFrequency
        
        self.motion = CMMotionManager()
    }
    
    public func start() {
        if isActive { return }
        
        isActive = true
    
        startDeviceMotion()
        
    }
    
    public func stop() {
        isActive = false
    }
    
    // MARK: - Actions
        
    private func startDeviceMotion() {
        
        if !isActive { return }
        
        motion.deviceMotionUpdateInterval = updateFrequency
        motion.showsDeviceMovementDisplay = false
        motion.startDeviceMotionUpdates(using: .xArbitraryZVertical)
        
        destroyTimer()
        
        // Configure a timer to fetch the motion data.
        self.timer = Timer(fire: Date(), interval: updateFrequency, repeats: true, block: { (timer) in
            
            if let motion = self.motion.deviceMotion {
                self.deviceMotion(motion)
            }
            
        })
        
        // Add the timer to the current run loop.
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
    }
    
    private func endDeviceMotion() {
        destroyTimer()
        motion.stopDeviceMotionUpdates()
    }
    
    private func destroyTimer() {
        if let timer  = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
}

@available(iOS 10.0, *)
extension IKSensorInterceptor {
    
    public func deviceMotion(_ capturedDeviceMotion: CMDeviceMotion) {
        for sensorType in IKSensorType.all {
            if sensorTypes.contains(sensorType) {
                let sensor = sensorFactory.sensor(capturedDeviceMotion, type: sensorType)
                let characteristics = sensorFactory.characteristics(from: sensor)
                let crumb = sensorFactory.crumb(with: characteristics, title: sensor.title)
                interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
            }
        }
    }
    
}
