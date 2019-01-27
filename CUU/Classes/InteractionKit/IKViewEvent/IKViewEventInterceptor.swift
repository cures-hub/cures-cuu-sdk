import UIKit

public class IKViewEventInterceptor: IKInterceptor {
    
    // MARK: - Properties
    
    private static var interceptors: [IKViewEventInterceptor] = []
    private var isActive: Bool = false
    
    public var interceptionDelegate: IKInterceptionDelegate
    public var viewEventFactory: IKViewEventFactory
    
    // MARK: - Lifecycle
    
    init(interceptionDelegate: IKInterceptionDelegate, viewEventFactory: IKViewEventFactory) {
        self.interceptionDelegate = interceptionDelegate
        self.viewEventFactory = viewEventFactory
        
        IKViewEventInterceptor.interceptors.append(self)
    }
    
    deinit {
        for i in  (0..<IKViewEventInterceptor.interceptors.count) {
            if IKViewEventInterceptor.interceptors[i] === self {
                IKViewEventInterceptor.interceptors.remove(at: i)
                return
            }
        }
    }
    
    // MARK: - Logging
    
    public static func log(_ viewController: UIViewController, type: IKViewEventType) {
        
        for interceptor in interceptors {
            interceptor.log(viewController, type:  type)
        }
        
    }
    
    private func log(_ viewController: UIViewController, type: IKViewEventType) {
        if isActive {
            let event = viewEventFactory.viewEvent(viewController: viewController, type: type)
            let characteristics = viewEventFactory.characteristics(from: event)
            let crumb = viewEventFactory.crumb(with: characteristics, title: event.title)
            interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
        }
    }
    
    // MARK: - Configuration
    
    public func start() {
        isActive = true
    }
    
    public func stop() {
        isActive = false
    }
}
