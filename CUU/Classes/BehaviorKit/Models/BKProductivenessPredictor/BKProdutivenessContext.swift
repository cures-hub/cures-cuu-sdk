public class BKProdutivenessContext: BKContext {
    
    public let type: String = "BKProdutivenessContext"
    
    public var _session: String = ""
    public var _user: String = ""
    public var timestamp: Date = Date()
    public var state: String = ""
    public var classProbability: [String : Double] = [:]
    
}

@available(iOS 11.0, *)
extension BKProdutivenessContext {
    
    static func from(_ output: ProdutivenessContextOutput) -> BKProdutivenessContext? {
        
        let context = BKProdutivenessContext()
        context.timestamp = Date()
        context.state = output.productivenessState
        context.classProbability = output.classProbability
        
        return context
        
    }
}


