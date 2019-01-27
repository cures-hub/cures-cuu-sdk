public class BKDefaultSituation: BKSituation {
    
    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var timestamp: Date = Date()
    public var context: [String : BKContext] = [:]
    
    public init() {
        
    }
    
}
