public class BKOrientationContext: BKContext {
    
    public let type: String = "BKOrientationContext"

    public var _session: String = ""
    public var _user: String = ""
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

