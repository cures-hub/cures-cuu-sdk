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
        let crumb = deviceFactory.crumb(from: device)
        interceptionDelegate.interceptor(self, captured: device, crumb: crumb)
        
    }
    
    public func stop() {
        // do nothing
    }
    
}
