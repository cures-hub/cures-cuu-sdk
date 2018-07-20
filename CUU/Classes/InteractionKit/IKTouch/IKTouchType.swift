public enum IKTouchType: String, CustomStringConvertible  {
    
    case touchBegan
    case touchMoved
    case touchEnded
    case touchIgnored
    
    public var description: String {
        return self.rawValue
    }
}
