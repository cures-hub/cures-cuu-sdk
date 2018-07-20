import UIKit

public protocol IKAppEventFactory {
    
    func appEvent(ofType type: IKAppEventType) -> IKAppEvent
    
}

extension IKAppEventFactory {
    
    public func populate(_ appEvent: IKAppEvent, ofType type: IKAppEventType) -> IKAppEvent {
        var appEvent = appEvent
        
        appEvent.title = type.description
        appEvent.type = "IKAppEvent"
        
        return appEvent
    }
    
    func crumb(from: IKAppEvent) -> IKAppEventCrumb {
        return IKAppEventCrumb(name: "IKAppEvent :: " + from.title, appEvent: from)
    }
}


