import UIKit

public protocol IKEventFactory {

    func event(title: String, parameter: [String:String]?) -> IKEvent
    
}

extension IKEventFactory {
    
    public func event(title: String) -> IKEvent {
        return event(title: title,  parameter: nil)
    }
 
    public func populate(_ event: IKEvent, title: String, parameter: [String : String]?) -> IKEvent {
        
        var event = event
        event.title = title
        event.type = "CustomEventType"
        event.parameter = parameter ?? [:]
        
        return event
    }
    
    func crumb(from: IKEvent) -> IKEventCrumb {
        return IKEventCrumb(name: "IKEvent :: " + from.title, event: from)
    }
    
}
