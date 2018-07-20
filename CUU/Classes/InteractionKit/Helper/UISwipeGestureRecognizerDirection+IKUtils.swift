extension UISwipeGestureRecognizerDirection: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .right:
            return "right"
        case .left:
            return "left"
        case .down:
            return "down"
        case .up:
            return "up"
        default:
            return ""
        }
    }
    
}
