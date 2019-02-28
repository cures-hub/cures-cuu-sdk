public class IKDefaultSensor: IKSensor {
    
    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var startDate: Date = Date()
    public var endDate: Date = Date()
    public var title: String = ""
    public var type: String = ""
    
    public var x: Double = 0.0
    public var y: Double = 0.0
    public var z: Double = 0.0
    
}

