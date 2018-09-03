public class BKGenderContext: BKContext {
    
    public let type: String = "BKGenderContext"
    
    public var _session: String = ""
    public var _user: String = ""
    public var timestamp: Date = Date()
    public var state: String = ""
    public var classProbability: [String : Double] = [:]
    
}

@available(iOS 11.0, *)
extension BKGenderContext {
    
    static func from(_ output: GenderContextOutput) -> BKGenderContext? {
        
        let context = BKGenderContext()
        context.timestamp = Date()
        context.state = output.gender
        context.classProbability = output.classProbability
        
        return context
        
    }
}


