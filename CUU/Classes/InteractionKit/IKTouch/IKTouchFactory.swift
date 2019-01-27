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

        touch.touchedElementTraits = "" //description(of: capturedTouch.view?.accessibilityTraits)
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

    /*func description(of accessibilityTraits: UIAccessibilityTraits?) -> String {
        guard let accessibilityTraits = accessibilityTraits else { return "" }
        let traits = AccessibilityTraits(rawValue: accessibilityTraits)
        var resultString = ""
        if traits.contains(.tabBar) {
            resultString += " TabBar"
        } else if traits.contains(.button) {
            resultString += " Button"
        } else if traits.contains(.link) {
            resultString += " Link"
        } else if traits.contains(.image) {
            resultString += " Image"
        } else if traits.contains(.keyboardKey) {
            resultString += " KeyboardKey"
        } else if traits.contains(.searchField) {
            resultString += " SearchField"
        } else if traits.contains(.header) {
            resultString += " Header"
        } else if traits.contains(.none) {
            resultString += " NoTrait"
        }

        return resultString.trimmingCharacters(in: .whitespacesAndNewlines)
    }*/
}

/*struct AccessibilityTraits: OptionSet {
    let rawValue: UIAccessibilityTraits

    static let button = AccessibilityTraits(rawValue: UIAccessibilityTraits.button)
    static let link = AccessibilityTraits(rawValue: UIAccessibilityTraits.link)
    static let image = AccessibilityTraits(rawValue: UIAccessibilityTraits.image)
    static let selected = AccessibilityTraits(rawValue: UIAccessibilityTraits.selected)
    static let playsSound = AccessibilityTraits(rawValue: UIAccessibilityTraits.playsSound)
    static let keyboardKey = AccessibilityTraits(rawValue: UIAccessibilityTraits.keyboardKey)
    static let staticText = AccessibilityTraits(rawValue: UIAccessibilityTraits.staticText)
    static let summaryElement = AccessibilityTraits(rawValue: UIAccessibilityTraits.summaryElement)
    static let notEnabled = AccessibilityTraits(rawValue: UIAccessibilityTraits.notEnabled)
    static let updatesFrequently = AccessibilityTraits(rawValue: UIAccessibilityTraits.updatesFrequently)
    static let searchField = AccessibilityTraits(rawValue: UIAccessibilityTraits.searchField)
    static let startsMediaSession = AccessibilityTraits(rawValue: UIAccessibilityTraits.startsMediaSession)
    static let adjustable = AccessibilityTraits(rawValue: UIAccessibilityTraits.adjustable)
    static let directInteraction = AccessibilityTraits(rawValue: UIAccessibilityTraits.allowsDirectInteraction)
    static let causesPageTurn = AccessibilityTraits(rawValue: UIAccessibilityTraits.causesPageTurn)
    static let header = AccessibilityTraits(rawValue: UIAccessibilityTraits.header)
    static let tabBar = AccessibilityTraits(rawValue: UIAccessibilityTraits.tabBar)
    static let none = AccessibilityTraits(rawValue: UIAccessibilityTraits.none)

    static func == (lhs: UIAccessibilityTraits, rhs: AccessibilityTraits) -> Bool {
        return lhs == rhs.rawValue
    }

    static func == (lhs: AccessibilityTraits, rhs: UIAccessibilityTraits) -> Bool {
        return lhs.rawValue == rhs
    }
}*/
