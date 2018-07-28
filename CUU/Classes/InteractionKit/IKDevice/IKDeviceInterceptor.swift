public class IKDeviceInterceptor: IKInterceptor {
    
    // MARK: - Properties
    
    public var interceptionDelegate: IKInterceptionDelegate
    public var deviceFactory: IKDeviceFactory
    
    // MARK: - Lifecycle
    
    init(interceptionDelegate: IKInterceptionDelegate, deviceFactory: IKDeviceFactory) {
        self.interceptionDelegate = interceptionDelegate
        self.deviceFactory = deviceFactory
    }
    
    public func start() {
        // emit just one event on start
        
        let device = deviceFactory.device()
        let characteristics = deviceFactory.characteristics(from: device)
        let crumb = deviceFactory.crumb(with: characteristics, title: device.title)
        interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
        
    }
    
    public func stop() {
        // do nothing
    }
    
}
