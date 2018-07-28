import UIKit

public protocol IKGestureFactory {
    
    func gesture(from gestureRecognizer: UITapGestureRecognizer) -> IKGesture
    func gesture(from gestureRecognizer: UIPinchGestureRecognizer) -> IKGesture
    func gesture(from gestureRecognizer: UIRotationGestureRecognizer) -> IKGesture
    func gesture(from gestureRecognizer: UISwipeGestureRecognizer) -> IKGesture
    func gesture(from gestureRecognizer: UIPanGestureRecognizer) -> IKGesture
    func gesture(from gestureRecognizer: UIScreenEdgePanGestureRecognizer) -> IKGesture
    func gesture(from gestureRecognizer: UILongPressGestureRecognizer) -> IKGesture
    
}


extension IKGestureFactory {
    

    private func populateCommonAttributes(_ gesture: IKGesture, from gestureRecognizer: UIGestureRecognizer) -> IKGesture {
        var gesture = gesture
        
        let location = gestureRecognizer.location(in: gestureRecognizer.view)
        gesture.locationX = Double(location.x)
        gesture.locationY = Double(location.y)
        gesture.touchCount =  gestureRecognizer.numberOfTouches
        
        return gesture
    }

    
    public func populate(_ gesture: IKGesture, from gestureRecognizer: UITapGestureRecognizer) -> IKGesture {
        var gesture = populateCommonAttributes(gesture, from: gestureRecognizer)

        gesture.title  = IKGestureType.tap.title
        gesture.type  = IKGestureType.tap.description
        
        return gesture
    }
    
    public func populate(_ gesture: IKGesture, from gestureRecognizer: UIPinchGestureRecognizer) -> IKGesture {
        var gesture = populateCommonAttributes(gesture, from: gestureRecognizer)

        gesture.title  = IKGestureType.pinch.title
        gesture.type  = IKGestureType.pinch.description
        
        gesture.scale = Double(gestureRecognizer.scale)
        gesture.scaleVelocity = Double(gestureRecognizer.velocity)
        
        return gesture
    }
    
    public func populate(_ gesture: IKGesture, from gestureRecognizer: UIRotationGestureRecognizer) -> IKGesture {
        var gesture = populateCommonAttributes(gesture, from: gestureRecognizer)

        gesture.title  = IKGestureType.rotation.title
        gesture.type  = IKGestureType.rotation.description
        
        gesture.rotation = Double(gestureRecognizer.rotation)
        gesture.rotationVelocity = Double(gestureRecognizer.velocity)
        
        return gesture
    }
    
    public func populate(_ gesture: IKGesture, from gestureRecognizer: UISwipeGestureRecognizer) -> IKGesture {
        var gesture = populateCommonAttributes(gesture, from: gestureRecognizer)

        gesture.title  = IKGestureType.swipe.title
        gesture.type  = IKGestureType.swipe.description
        
        gesture.direction = "\(gestureRecognizer.direction)"
        
        return gesture
    }
    
    public func populate(_ gesture: IKGesture, from gestureRecognizer: UIPanGestureRecognizer) -> IKGesture {
        var gesture = populateCommonAttributes(gesture, from: gestureRecognizer)

        gesture.title  = IKGestureType.pan.title
        gesture.type  = IKGestureType.pan.description
        
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
        gesture.translationX = Double(translation.x)
        gesture.translationY = Double(translation.y)
        
        let velocity = gestureRecognizer.velocity(in: gestureRecognizer.view)
        gesture.velocityX = Double(velocity.x)
        gesture.velocityY = Double(velocity.y)
        
        return gesture
    }
    
    public func populate(_ gesture: IKGesture, from gestureRecognizer: UIScreenEdgePanGestureRecognizer) -> IKGesture {
        var gesture = populateCommonAttributes(gesture, from: gestureRecognizer)

        gesture.title  = IKGestureType.screenPan.title
        gesture.type  = IKGestureType.screenPan.description
        
        return gesture
    }
    
    public func populate(_ gesture: IKGesture, from gestureRecognizer: UILongPressGestureRecognizer) -> IKGesture {
        var gesture = populateCommonAttributes(gesture, from: gestureRecognizer)

        gesture.title  = IKGestureType.longPress.title
        gesture.type  = IKGestureType.longPress.description
        
        return gesture
    }
    
    func characteristics(from: IKGesture) -> IKGestureCharacteristics {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        return IKGestureCharacteristics(context: context, gesture: from)
    }
    
    func crumb(with characteristics: IKGestureCharacteristics, title: String) -> IKInteraction {
        let config = InteractionKit.shared.configuration
        let context = config!.storage.persistentContainer.viewContext
        
        return IKInteraction(context: context,
                             name: "IKGesture :: " + title,
                             characteristics: characteristics)
    }
}

