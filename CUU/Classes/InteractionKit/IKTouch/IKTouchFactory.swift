import UIKit
import Foundation

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

        touch.touchedElementTraits = description(of: capturedTouch.view?.accessibilityTraits)
        touch.touchedElementLabel = capturedTouch.view?.accessibilityLabel ?? ""
        touch.touchedElementValue = capturedTouch.view?.accessibilityValue ?? ""

        if let view = capturedTouch.view, type == .touchEnded {
            let centerRect = CGRect(x: view.frame.width / 4,
                                    y: view.frame.height / 4,
                                    width: view.frame.width / 2,
                                    height: view.frame.height / 2)
            touch.touchIsPrecise = centerRect.contains(location)
        }

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

extension IKTouchFactory {

    func description(of accessibilityTraits: UIAccessibilityTraits?) -> String {
        guard let accessibilityTraits = accessibilityTraits else { return "" }
        var resultString = ""
        if accessibilityTraits.contains(.tabBar) {
            resultString += " TabBar"
        } else if accessibilityTraits.contains(.button) {
            resultString += " Button"
        } else if accessibilityTraits.contains(.link) {
            resultString += " Link"
        } else if accessibilityTraits.contains(.image) {
            resultString += " Image"
        } else if accessibilityTraits.contains(.keyboardKey) {
            resultString += " KeyboardKey"
        } else if accessibilityTraits.contains(.searchField) {
            resultString += " SearchField"
        } else if accessibilityTraits.contains(.header) {
            resultString += " Header"
        } else if accessibilityTraits.contains(.none) {
            resultString += " NoTrait"
        }

        return resultString.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
