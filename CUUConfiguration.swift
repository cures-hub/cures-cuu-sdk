public class CUUConfiguration {
    
    open var applicationKey: String = ""
    open var buildComment: String = ""
    
    public init() {
        
    }
    
    public var interactionKitConfiguration: IKConfiguration {
        return UKDevelopConfiguration(forUser: CUUUserManager.sharedManager.userId)
    }
}
