public protocol IKMotionFactory {
    
    func motion(_ capturedMotion: UIEventSubtype, type: IKMotionType) -> IKMotion?
    
}


extension IKMotionFactory {
    public func populate(_ motion: IKMotion, eventType: UIEventSubtype, ofType type: IKMotionType) -> IKMotion? {
        
        if eventType != .motionShake {
            return nil
        }
        
        var motion = motion
        motion.title  = "MotionShake"
        motion.type  = type.description
        
        return motion
    }
    
    func crumb(from: IKMotion) -> IKMotionCrumb {
        return IKMotionCrumb(name: "IKMotion :: " + from.title, motion: from)
    }
}

