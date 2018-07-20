import UIKit
import UIKit.UIGestureRecognizerSubclass

public class IKTouchInterceptor: UIGestureRecognizer, IKInterceptor {
    
    // MARK: - Properties
    
    private var window: UIWindow
    public var interceptionDelegate: IKInterceptionDelegate
    public var touchFactory: IKTouchFactory
    
    // MARK: - Lifecycle
    
    public init(window: UIWindow, interceptionDelegate: IKInterceptionDelegate, touchFactory: IKTouchFactory) {
        
        self.window = window
        self.interceptionDelegate = interceptionDelegate
        self.touchFactory =  touchFactory

        super.init(target: nil, action: nil)
        
        // make sure not to block events for underlying views
        cancelsTouchesInView = false
        delaysTouchesBegan = false
        delaysTouchesEnded = false
    }
    
    public func start() {
        window.addGestureRecognizer(self)
    }
    
    public func stop() {
        window.removeGestureRecognizer(self)
    }
    
}

// MARK: - UIGestureRecognizer
extension IKTouchInterceptor {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        
        for touch in touches {
            let touchObject = touchFactory.touch(touch, type: .touchBegan)
            let crumb = touchFactory.crumb(from: touchObject)
            interceptionDelegate.interceptor(self, captured: touchObject, crumb: crumb)
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            let touchObject = touchFactory.touch(touch, type: .touchMoved)
            let crumb = touchFactory.crumb(from: touchObject)
            interceptionDelegate.interceptor(self, captured: touchObject, crumb: crumb)
        }
        
        super.touchesMoved(touches, with: event)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            let touchObject = touchFactory.touch(touch, type: .touchEnded)
            let crumb = touchFactory.crumb(from: touchObject)
            interceptionDelegate.interceptor(self, captured: touchObject, crumb: crumb)
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        for touch in touches {
            let touchObject = touchFactory.touch(touch, type: .touchEnded)
            let crumb = touchFactory.crumb(from: touchObject)
            interceptionDelegate.interceptor(self, captured: touchObject, crumb: crumb)
        }
        
        super.touchesCancelled(touches, with: event)
    }
    
    override public func ignore(_ touch: UITouch, for event: UIEvent) {
        let touchObject = touchFactory.touch(touch, type: .touchIgnored)
        let crumb = touchFactory.crumb(from: touchObject)
        interceptionDelegate.interceptor(self, captured: touchObject, crumb: crumb)
    }
    
}

