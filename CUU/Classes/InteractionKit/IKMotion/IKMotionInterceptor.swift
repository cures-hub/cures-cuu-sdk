import Foundation
import CoreMotion

@available(iOS 10.0, *)
public class IKMotionInterceptor: IKInterceptor  {

    // Implementing shake detecting lead to problems, when the app utilized the first responder chain,
    // so as a workaround we listen for shakes ourselves
    
    // MARK: - Properties
    
    public var interceptionDelegate: IKInterceptionDelegate
    public var motionFactory: IKMotionFactory
    public var motionShakeDetector: IKCoreMotionShakeDetector
    
    // MARK: - Lifecycle
    
    init(interceptionDelegate: IKInterceptionDelegate, motionFactory: IKMotionFactory) {
        self.interceptionDelegate = interceptionDelegate
        self.motionFactory = motionFactory
        self.motionShakeDetector = IKCoreMotionShakeDetector()
    }
    
    public func start() {
        motionShakeDetector.delegate = self
        motionShakeDetector.startShakeUpdates()
    }
    
    public func stop() {
        motionShakeDetector.stopShakeUpdates()
    }
    
}

/**
 *  IKCoreMotionShakeDelegate.
 **/
@available(iOS 10.0, *)
extension IKMotionInterceptor: IKCoreMotionShakeDelegate {
    
    public func report(motion: UIEvent.EventSubtype, of type: IKMotionType) {
        if let motionObject = motionFactory.motion(motion, type: type) {
            let characteristics = motionFactory.characteristics(from: motionObject)
            let crumb = motionFactory.crumb(with: characteristics, title: motionObject.title)
            interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
        }
    }
}



