class IKDefaultViewEventFactory: IKViewEventFactory {
    
    func viewEvent(viewController: UIViewController, type: IKViewEventType) -> IKViewEvent {
        let viewEvent = IKDefaultViewEvent()
        return populate(viewEvent, viewController: viewController, ofType: type)
    }
    
}

