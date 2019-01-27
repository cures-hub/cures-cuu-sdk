public class BKUXInconsistencyContext: BKContext {
    
    public let type: String = "BKUXInconsistencyContext"
    
    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var timestamp: Date = Date()
    public var state: String = ""
    public var classProbability: [String : Double] = [:]
    
}

@available(iOS 11.0, *)
extension BKUXInconsistencyContext {
    
    static func from(_ output: UXInconsistencyContextOutput) -> BKUXInconsistencyContext? {
        
        let context = BKUXInconsistencyContext()
        context.timestamp = Date()
        context.state = "\(output.uxInconsistencyState)"
        context.classProbability = transformDict(output.classProbability)
        
        return context
        
    }
    
    private static func transformDict(_ source: [Int64 : Double]) -> [String : Double] {
        var output: [String: Double] = [:]
        for (key, value) in source {
            output["\(key)"] = value
        }
        return output
    }
}



