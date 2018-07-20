class IKDefaultEventFactory: IKEventFactory {
    
    func event(title: String, parameter: [String : String]?) -> IKEvent {
        let event = IKDefaultEvent()
        return populate(event, title: title, parameter: parameter)
    }
    
}

