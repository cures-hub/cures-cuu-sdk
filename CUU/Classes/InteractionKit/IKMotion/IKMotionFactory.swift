public protocol IKMotionFactory {
    
    func motion(_ capturedMotion: UIEvent.EventSubtype, type: IKMotionType) -> IKMotion?
    
}


extension IKMotionFactory {
    public func populate(_ motion: IKMotion, eventType: UIEvent.EventSubtype, ofType type: IKMotionType) -> IKMotion? {
        
        if eventType != .motionShake {
            return nil
        }
        
        var motion = motion
        motion.title  = "MotionShake"
        motion.type  = type.description
        
        return motion
    }
    
    func characteristics(from: IKMotion) -> IKMotionCharacteristics {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        return IKMotionCharacteristics(context: context, motion: from)
    }
    
    func crumb(with characteristics: IKMotionCharacteristics, title: String) -> IKInteraction {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        
        return IKInteraction(context: context,
                             name: "IKMotion :: " + title,
                             characteristics: characteristics)
    }
}

