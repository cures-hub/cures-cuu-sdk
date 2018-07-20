public enum IKSensorType: String, CustomStringConvertible {
    
    case attitude
    case rotation
    case acceleration
    case gravity
    
    public var description: String {
        return self.rawValue
    }
    
    public static var all: [IKSensorType] {
        return [.attitude, .rotation, .acceleration]
    }
    
}

