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
        
        return touch
    }
    
    func crumb(from: IKTouch) -> IKTouchCrumb {
        return IKTouchCrumb(name: "IKTouch :: " + from.title, touch: from)
    }
}

extension IKTouchFactory {

    func description(of accessibilityTraits: UIAccessibilityTraits?) -> String {
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
    }
}

struct AccessibilityTraits: OptionSet {
    let rawValue: UIAccessibilityTraits

    static let button = AccessibilityTraits(rawValue: UIAccessibilityTraitButton)
    static let link = AccessibilityTraits(rawValue: UIAccessibilityTraitLink)
    static let image = AccessibilityTraits(rawValue: UIAccessibilityTraitImage)
    static let selected = AccessibilityTraits(rawValue: UIAccessibilityTraitSelected)
    static let playsSound = AccessibilityTraits(rawValue: UIAccessibilityTraitPlaysSound)
    static let keyboardKey = AccessibilityTraits(rawValue: UIAccessibilityTraitKeyboardKey)
    static let staticText = AccessibilityTraits(rawValue: UIAccessibilityTraitStaticText)
    static let summaryElement = AccessibilityTraits(rawValue: UIAccessibilityTraitSummaryElement)
    static let notEnabled = AccessibilityTraits(rawValue: UIAccessibilityTraitNotEnabled)
    static let updatesFrequently = AccessibilityTraits(rawValue: UIAccessibilityTraitUpdatesFrequently)
    static let searchField = AccessibilityTraits(rawValue: UIAccessibilityTraitSearchField)
    static let startsMediaSession = AccessibilityTraits(rawValue: UIAccessibilityTraitStartsMediaSession)
    static let adjustable = AccessibilityTraits(rawValue: UIAccessibilityTraitAdjustable)
    static let directInteraction = AccessibilityTraits(rawValue: UIAccessibilityTraitAllowsDirectInteraction)
    static let causesPageTurn = AccessibilityTraits(rawValue: UIAccessibilityTraitCausesPageTurn)
    static let header = AccessibilityTraits(rawValue: UIAccessibilityTraitHeader)
    static let tabBar = AccessibilityTraits(rawValue: UIAccessibilityTraitTabBar)
    static let none = AccessibilityTraits(rawValue: UIAccessibilityTraitNone)

    static func == (lhs: UIAccessibilityTraits, rhs: AccessibilityTraits) -> Bool {
        return lhs == rhs.rawValue
    }

    static func == (lhs: AccessibilityTraits, rhs: UIAccessibilityTraits) -> Bool {
        return lhs.rawValue == rhs
    }
}
