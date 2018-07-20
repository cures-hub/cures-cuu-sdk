public enum IKAppEventType: String, CustomStringConvertible {
    
    case didLaunch
    case didBecomeActive
    case didResignActive
    case didEnterForeground
    case didEnterBackground
    case didTerminate
    case didReceiveMemoryWarning
    case keyboardDidShow
    case keyboardDidHide
    // todo add more
    
    public var description: String {
        return self.rawValue
    }
}

