public enum IKGestureType: String, CustomStringConvertible {
    
    case tap
    case pinch
    case rotation
    case swipe
    case pan
    case screenPan
    case longPress

    public var title: String {
        switch self {
        case .tap:
            return "UITapGesture"
        case .pinch:
            return "UIPinchGesture"
        case .rotation:
            return "UIRotationGesture"
        case .swipe:
            return "UISwipeGesture"
        case .pan:
            return "UIPanGesture"
        case .screenPan:
            return "UIScreenPanGesture"
        case .longPress:
            return "UILongPressGesture"
        }
    }
    
    public var description: String {
        return self.rawValue
    }
    
    public static var all: [IKGestureType] {
        return [.tap, .pinch, .rotation, .swipe, .pan, .screenPan, .longPress]
    }
}
