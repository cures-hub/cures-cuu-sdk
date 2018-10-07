public class BKProductivenessContext: BKContext {
    
    public let type: String = "BKProductivenessContext"
    
    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var timestamp: Date = Date()
    public var state: String = ""
    public var classProbability: [String : Double] = [:]
    
}

@available(iOS 11.0, *)
extension BKProductivenessContext {
    
    static func from(_ output: ProdutivenessContextOutput) -> BKProductivenessContext? {
        
        let context = BKProductivenessContext()
        context.timestamp = Date()
        context.state = output.productivenessState
        context.classProbability = output.classProbability
        
        return context
        
    }
}


