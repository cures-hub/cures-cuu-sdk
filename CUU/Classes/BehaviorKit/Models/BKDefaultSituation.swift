public class BKDefaultSituation: BKSituation {
    
    public var _session: String = ""
    public var _user: String = ""
    public var timestamp: Date = Date()
    public var context: [String : BKContext] = [:]
    
    public init() {
        
    }
    
}
