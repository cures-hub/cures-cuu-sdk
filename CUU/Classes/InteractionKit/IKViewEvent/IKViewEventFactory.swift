import UIKit

public protocol IKViewEventFactory {
    
    func viewEvent(viewController: UIViewController, type: IKViewEventType) -> IKViewEvent

}

extension IKViewEventFactory {
    
    public func populate(_ viewEvent: IKViewEvent, viewController: UIViewController, ofType type: IKViewEventType) -> IKViewEvent {
        var viewEvent = viewEvent
        
        viewEvent.title = type.description
        viewEvent.type = "IKViewEvent"
        
        viewEvent.viewControllerTitle = viewController.title ?? viewController.accessibilityLabel ?? ""
        viewEvent.viewControllerType = viewController.typeName
        viewEvent.viewControllerInstance = viewController.instanceIdentifier
        viewEvent.viewWidth = Double(viewController.view.frame.width)
        viewEvent.viewHeight = Double(viewController.view.frame.height)
        viewEvent.viewOriginX = Double(viewController.view.frame.origin.x)
        viewEvent.viewOriginY = Double(viewController.view.frame.origin.y)
        
        if let rootWindow = UIApplication.shared.keyWindow {
            let globalViewFrame = rootWindow.convert(viewController.view.frame, from: viewController.view)
            viewEvent.globalViewOriginX = Double(globalViewFrame.origin.x)
            viewEvent.globalViewOriginY = Double(globalViewFrame.origin.y)
        }
        viewEvent.subviewCount = Int(viewController.view.subviewCount)
        
        return viewEvent
    }
    
    func characteristics(from: IKViewEvent) -> IKViewEventCharacteristics {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        return IKViewEventCharacteristics(context: context, viewEvent: from)
    }
    
    func crumb(with characteristics: IKViewEventCharacteristics, title: String) -> IKInteraction {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        
        return IKInteraction(context: context,
                             name: "IKViewEvent :: " + title,
                             characteristics: characteristics)
    }
}
