public class IKDefaultAppEventFactory: IKAppEventFactory {
    
    public func appEvent(ofType type: IKAppEventType) -> IKAppEvent {
        let appEvent = IKDefaultAppEvent()
        return populate(appEvent, ofType: type)
    }
    
}
