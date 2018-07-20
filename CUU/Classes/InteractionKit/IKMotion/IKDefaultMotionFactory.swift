class IKDefaultMotionFactory: IKMotionFactory {
    
    func motion(_ capturedMotion: UIEventSubtype, type: IKMotionType) -> IKMotion? {
        let motion = IKDefaultMotion()
        return populate(motion, eventType: capturedMotion, ofType: type)
    }
    
}

