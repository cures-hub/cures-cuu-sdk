public enum IKViewEventType: String, CustomStringConvertible {
    
    case didAppear
    case didDisappear
    
    public var description: String {
        return self.rawValue
    }
}
