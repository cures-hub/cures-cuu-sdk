class IKDefaultMotionFactory: IKMotionFactory {

    func motion(_ capturedMotion: UIEvent.EventSubtype, type: IKMotionType) -> IKMotion? {
        let motion = IKDefaultMotion()
        return populate(motion, eventType: capturedMotion, ofType: type)
    }
    
}

