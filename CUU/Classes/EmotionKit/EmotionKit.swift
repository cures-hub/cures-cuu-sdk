import ARKit

open class EmotionKit {
    let observer = EKCrumbObserver()

    public static var isSupported: Bool {
        guard let _ = CUUConstants.cameraDescription else { return false }
        return ARFaceTrackingConfiguration.isSupported
    }

    private(set) static var isActive = false
    
    public func start() {
        EmotionKit.isActive = true
    }
    
    public func stop() {
        EmotionKit.isActive = false
    }
}
