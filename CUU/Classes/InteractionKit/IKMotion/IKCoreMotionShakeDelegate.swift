public protocol IKCoreMotionShakeDelegate {
    
    func report(motion: UIEvent.EventSubtype, of type: IKMotionType)

}
