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
    
    func characteristics(from: IKEvent) -> IKEventCharacteristics {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        return IKEventCharacteristics(context: context, event: from)
    }
    
    func crumb(with characteristics: IKEventCharacteristics, title: String) -> IKInteraction {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        
        return IKInteraction(context: context,
                             name: "IKEvent :: " + title,
                             characteristics: characteristics)
    }
}
