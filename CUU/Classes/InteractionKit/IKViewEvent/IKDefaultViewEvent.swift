public class IKDefaultViewEvent: IKViewEvent {
    
    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var startDate: Date = Date()
    public var endDate: Date = Date()
    public var title: String = ""
    public var type: String = ""
    public var viewControllerTitle: String = ""
    public var viewControllerType: String = ""
    public var viewControllerInstance: String = ""
    public var viewWidth: Double = 0.0
    public var viewHeight: Double = 0.0
    public var viewOriginX: Double = 0.0
    public var viewOriginY: Double = 0.0
    public var globalViewOriginX: Double = 0.0
    public var globalViewOriginY: Double = 0.0
    public var subviewCount: Int = 0    
}



