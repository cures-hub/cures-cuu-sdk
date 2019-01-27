public class BKOrientationContext: BKContext {
    
    public let type: String = "BKOrientationContext"

    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var timestamp: Date = Date()
    public var state: String = ""
    public var classProbability: [String : Double] = [:]
    
}

@available(iOS 11.0, *)
extension BKOrientationContext {
    
    static func from(_ output: OrientationContextOutput) -> BKOrientationContext? {
        
        let context = BKOrientationContext()
        context.timestamp = Date()
        context.state = output.orientationState
        context.classProbability = output.classProbability
        
        return context
        
    }
}

