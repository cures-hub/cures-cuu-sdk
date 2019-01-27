import UIKit
import UIKit.UIGestureRecognizerSubclass

public class IKMultiDirectionSwipeGestureRecognizer: UIGestureRecognizer {
    
    // MARK: - Properties
    
    private let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
    private var recognizers: [UInt: UISwipeGestureRecognizer] = [:]
    private var action: Selector?
    private var target: Any?
    
    override public var isEnabled: Bool {
        didSet {
            syncChildRecognizers()
        }
    }
    override public var cancelsTouchesInView: Bool {
        didSet {
            syncChildRecognizers()
        }
    }
    override public var delaysTouchesBegan: Bool {
        didSet {
            syncChildRecognizers()
        }
    }
    override public var delaysTouchesEnded: Bool {
        didSet {
            syncChildRecognizers()
        }
    }
    
    // MARK: - Lifecycle
    
    convenience init() {
        self.init(target: nil, action: nil)
    }
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        
        self.target = target
        self.action = action
        
        setupChildRecognizers()
    }
    
    // MARK: - Actions
    
    override public func addTarget(_ target: Any, action: Selector) {
        super.addTarget(target, action: action)
        
        self.target = target
        self.action = action
        
        self.action = action
    }
    
    // MARK: - Configuration
    
    private func setupChildRecognizers(){
        for direction in directions {
            recognizers[direction.rawValue] = UISwipeGestureRecognizer(target: self, action: #selector(childRecognizerFired))
            recognizers[direction.rawValue]?.direction = direction
        }
        syncChildRecognizers()
    }
    
    private func syncChildRecognizers() {
        for direction in directions {
            recognizers[direction.rawValue]?.isEnabled = isEnabled
            recognizers[direction.rawValue]?.cancelsTouchesInView = cancelsTouchesInView
            recognizers[direction.rawValue]?.delaysTouchesBegan = delaysTouchesBegan
            recognizers[direction.rawValue]?.delaysTouchesEnded = delaysTouchesEnded
        }
    }
    
    private func syncAttachedView() {
        for direction in directions {
            if let childGestureRecognizer = recognizers[direction.rawValue] {
                if self.view !== childGestureRecognizer.view {
                    childGestureRecognizer.view?.removeGestureRecognizer(childGestureRecognizer)
                    self.view?.addGestureRecognizer(childGestureRecognizer)
                }
                
            }
        }
    }
    
    @objc func childRecognizerFired(_ sender: UISwipeGestureRecognizer) {
        if let action = action, let target = target {
            UIApplication.shared.sendAction(action, to: target, from: sender, for: nil)
        }
    }

}


// MARK: - UIGestureRecognizer
extension IKMultiDirectionSwipeGestureRecognizer {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        syncAttachedView()
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        syncAttachedView()

    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        syncAttachedView()

    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        syncAttachedView()
    }
    
}
