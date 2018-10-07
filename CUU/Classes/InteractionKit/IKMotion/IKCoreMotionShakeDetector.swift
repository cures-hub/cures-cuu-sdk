import CoreMotion

@available(iOS 10.0, *)
public class IKCoreMotionShakeDetector {
    
    // MARK: - Properties
    
    private var timer: Timer?
    private let motion: CMMotionManager
    private var updateFrequency: TimeInterval
    private var previousMotion: CMDeviceMotion
    
    public var delegate: IKCoreMotionShakeDelegate?
    public var accelerationThreshold: Double
    
    // MARK: - Lifecycle
    
    init(delegate: IKCoreMotionShakeDelegate? = nil, accelerationThreshold: CGFloat = 0.3) {
        self.motion = CMMotionManager()
        
        self.accelerationThreshold = 0.3
        self.delegate = delegate
        self.updateFrequency =  1.0/60.0
        self.previousMotion = CMDeviceMotion()
    }
    
    // MARK: - Actions
    
    public func startShakeUpdates() {
        
        motion.deviceMotionUpdateInterval = updateFrequency
        motion.showsDeviceMovementDisplay = false
        motion.startDeviceMotionUpdates(using: .xArbitraryZVertical)
        
        destroyTimer()
        
        // Configure a timer to fetch the motion data.
        self.timer = Timer(fire: Date(), interval: updateFrequency, repeats: true, block: { (timer) in
            
            if let motion = self.motion.deviceMotion {
                self.analyse(motion)
            }
            
        })
        
        // Add the timer to the current run loop.
        RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
    }
    
    public func stopShakeUpdates() {
        destroyTimer()
        motion.stopDeviceMotionUpdates()
    }
    
    private func destroyTimer() {
        if let timer  = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    private func analyse(_ motion: CMDeviceMotion) {
        
        if (fabs(motion.userAcceleration.x) > accelerationThreshold ||
            fabs(motion.userAcceleration.y) > accelerationThreshold ||
            fabs(motion.userAcceleration.z) > accelerationThreshold) {
            
            let sensitivity: Double = 1;
            var x1: Double  = 0
            var y1: Double  = 0
            var z1: Double  = 0
            let x2: Double  = previousMotion.userAcceleration.x
            let y2: Double  = previousMotion.userAcceleration.y
            let z2: Double  = previousMotion.userAcceleration.z
            
            let totalAccelerationInXY: Double = sqrt(motion.userAcceleration.x * motion.userAcceleration.x + motion.userAcceleration.y * motion.userAcceleration.y);
            
            if (0.85 < totalAccelerationInXY && totalAccelerationInXY < 3.45) {
                x1 = motion.userAcceleration.x;
                y1 = motion.userAcceleration.y;
                z1 = motion.userAcceleration.z;
                
                let change = fabs(x1-x2+y1-y2+z1-z2);
                if (sensitivity < change) {
                    delegate?.report(motion: UIEvent.EventSubtype.motionShake, of: .began)
                }
            }
        }
        
        previousMotion = motion
        
    }
    
}

