public class IKDefaultGesture: IKGesture {
    
    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var startDate: Date = Date()
    public var endDate: Date = Date()
    public var title: String = ""
    public var type: String = ""
    
    public var touchCount: Int = 0
    public var locationX: Double = 0.0
    public var locationY: Double = 0.0
    
    public var scale: Double = 0.0
    public var scaleVelocity: Double = 0.0
    
    public var rotation: Double = 0.0
    public var rotationVelocity: Double = 0.0
    
    public var direction: String = ""
    
    public var translationX: Double = 0.0
    public var translationY: Double = 0.0
    public var velocityX: Double = 0.0
    public var velocityY: Double = 0.0
    
}
