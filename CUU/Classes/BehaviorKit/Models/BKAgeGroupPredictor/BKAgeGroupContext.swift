public class BKAgeGroupContext: BKContext {
    
    public let type: String = "BKAgeGroupContext"
    
    public var _session: String = ""
    public var _user: String = ""
    public var timestamp: Date = Date()
    public var state: String = ""
    public var classProbability: [String : Double] = [:]
    
}

@available(iOS 11.0, *)
extension BKAgeGroupContext {
    
    static func from(_ output: AgeGroupContextOutput) -> BKAgeGroupContext? {
        
        let context = BKAgeGroupContext()
        context.timestamp = Date()
        context.state = output.ageGroup
        for (key, value) in output.classProbability {
            context.classProbability[key] = value / 10.0
        }
    
        
        return context
        
    }
}


