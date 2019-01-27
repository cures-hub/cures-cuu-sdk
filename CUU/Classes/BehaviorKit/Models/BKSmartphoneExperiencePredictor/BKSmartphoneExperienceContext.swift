public class BKSmartphoneExperienceContext: BKContext {
    
    public let type: String = "BKSmartphoneExperienceContext"
    
    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var timestamp: Date = Date()
    public var state: String = ""
    public var classProbability: [String : Double] = [:]
    
}

@available(iOS 11.0, *)
extension BKSmartphoneExperienceContext {
    
    static func from(_ output: SmartphoneExperienceContextOutput) -> BKSmartphoneExperienceContext? {
        
        let context = BKSmartphoneExperienceContext()
        context.timestamp = Date()
        context.state = output.smartphoneExperience
        context.classProbability = output.classProbability
        
        return context
        
    }
}



