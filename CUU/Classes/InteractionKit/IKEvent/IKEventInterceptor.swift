import UIKit

public class IKEventInterceptor: IKInterceptor {
    
    // MARK: - Properties
    
    private static var interceptors: [IKEventInterceptor] = []
    private var isActive: Bool = false
    
    public var interceptionDelegate: IKInterceptionDelegate
    public var eventFactory: IKEventFactory
    
    // MARK: - Lifecycle
    
    init(interceptionDelegate: IKInterceptionDelegate, eventFactory: IKEventFactory) {
        self.interceptionDelegate = interceptionDelegate
        self.eventFactory = eventFactory
        
        IKEventInterceptor.interceptors.append(self)
    }
    
    deinit {
        for i in  (0..<IKEventInterceptor.interceptors.count) {
            if IKEventInterceptor.interceptors[i] === self {
                IKEventInterceptor.interceptors.remove(at: i)
                return
            }
        }
    }
    
    // MARK: - Logging
    
    public static func log(title: String, parameter: [String:String]? = nil ) {
        for interceptor in interceptors {
            interceptor.log(title: title, parameter: parameter)
        }
        
    }
    
    private func log(title: String, parameter: [String:String]? = nil ) {
        if isActive {
            let event = eventFactory.event(title: title, parameter: parameter)
            let crumb = eventFactory.crumb(from: event)
            interceptionDelegate.interceptor(self, captured: event, crumb: crumb)
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

