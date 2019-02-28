public class IKDefaultTouch: IKTouch {

    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var startDate: Date = Date()
    public var endDate: Date = Date()
    public var title: String = ""
    public var type: String = ""
    
    public var tapCount: Int = 0
    public var force: Double = 0.0
    public var locationX: Double = 0.0
    public var locationY: Double = 0.0
    public var previousLocationX: Double = 0.0
    public var previousLocationY: Double = 0.0
    public var parameter: [String:String] =  [:]

    public var touchedElementTraits: String = ""
    public var touchedElementLabel: String = ""
    public var touchedElementValue: String = ""
    public var touchIsPrecise: Bool = false
}



