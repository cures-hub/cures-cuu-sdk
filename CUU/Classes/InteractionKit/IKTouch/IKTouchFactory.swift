import UIKit

public protocol IKTouchFactory {
    
    func touch(_ capturedTouch: UITouch, type: IKTouchType) -> IKTouch

}

extension IKTouchFactory {
    
    public func populate(_ touch: IKTouch, capturedTouch: UITouch, ofType type: IKTouchType) -> IKTouch {
        
        var touch = touch
        touch.title = type.description
        touch.type = "IKTouch"
        
        touch.tapCount = capturedTouch.tapCount
        touch.force =  Double(capturedTouch.force)
        
        let location = capturedTouch.location(in: capturedTouch.view)
        
        touch.locationX = Double(location.x)
        touch.locationY = Double(location.y)
        
        let previousLocation = capturedTouch.previousLocation(in: capturedTouch.view)
        
        touch.previousLocationX = Double(previousLocation.x)
        touch.previousLocationY = Double(previousLocation.y)
        
        return touch
    }
    
    func characteristics(from: IKTouch) -> IKTouchCharacteristics {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        return IKTouchCharacteristics(context: context, touch: from)
    }
    
    func crumb(with characteristics: IKTouchCharacteristics, title: String) -> IKInteraction {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        
        return IKInteraction(context: context,
                             name: "IKTouch :: " + title,
                             characteristics: characteristics)
    }
}

