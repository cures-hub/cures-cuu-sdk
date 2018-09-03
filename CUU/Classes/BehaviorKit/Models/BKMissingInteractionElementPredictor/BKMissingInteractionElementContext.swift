public class BKMissingInteractionElementContext: BKContext {
    
    public let type: String = "BKMissingInteractionElementContext"
    
    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var timestamp: Date = Date()
    public var state: String = ""
    public var classProbability: [String : Double] = [:]
    
}

@available(iOS 11.0, *)
extension BKMissingInteractionElementContext {
    
    static func from(_ output: MissingInteractionElementContextOutput) -> BKMissingInteractionElementContext? {
        
        let context = BKMissingInteractionElementContext()
        context.timestamp = Date()
        context.state = "\(output.missingUIElementState)"
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




