import UIKit

public class IKAppEventInterceptor: IKInterceptor {
    
    // MARK: - Properties
    
    private var isActive: Bool = false
    private var isConfigured: Bool = false
    
    public var interceptionDelegate: IKInterceptionDelegate
    public var appEventFactory: IKAppEventFactory
    
    // MARK: - Lifecycle
    
    init(interceptionDelegate: IKInterceptionDelegate, appEventFactory: IKAppEventFactory) {
        self.interceptionDelegate = interceptionDelegate
        self.appEventFactory = appEventFactory
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)   
    }
    
    // MARK: - Utils
    
    func log(_ type: IKAppEventType)  {
        if isActive {
            let event = appEventFactory.appEvent(ofType: type)
            let characteristics = appEventFactory.characteristics(from: event)
            let crumb = appEventFactory.crumb(with: characteristics, title: event.title)
            interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
        }
    }
    
    // MARK: - Configuration
    
    public func start() {
        configureAppEventTracking()
        isActive = true
//        log(.didLaunch)
    }
    
    public func stop() {
        isActive = false
    }
    
    private func configureAppEventTracking() {
        if isConfigured  { return }
        
        let mainQueue = OperationQueue.main

        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidFinishLaunching, object: nil, queue: mainQueue, using: { _ in
            self.log(.didLaunch)
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillTerminate, object: nil, queue: mainQueue, using: { _ in
            self.log(.didTerminate)
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: mainQueue, using: { _ in
            self.log(.didBecomeActive)
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillResignActive, object: nil, queue: mainQueue, using: { _ in
            self.log(.didResignActive)
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: mainQueue, using: { _ in
            self.log(.didEnterBackground)
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationWillEnterForeground, object: nil, queue: mainQueue, using: { _ in
            self.log(.didEnterForeground)
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil, queue: mainQueue, using: { _ in
            self.log(.didReceiveMemoryWarning)
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: mainQueue, using: { _ in
            self.log(.keyboardDidShow)
        })
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: mainQueue, using: { _ in
            self.log(.keyboardDidHide)
        })
        
        isConfigured = true
        
    }
    
}
