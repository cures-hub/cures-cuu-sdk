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
    
    func characteristics(from: IKAppEvent) -> IKAppEventCharacteristics {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        return IKAppEventCharacteristics(context: context, appEvent: from)
    }
    
    func crumb(with characteristics: IKAppEventCharacteristics, title: String) -> IKInteraction {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        
        return IKInteraction(context: context,
                                 name: "IKAppEvent :: " + title,
                                 characteristics: characteristics)
    }
}


