public enum IKMotionType: String, CustomStringConvertible {
    
    case began
    case ended
    case cancelled

    public var description: String {
        return self.rawValue
    }
}

