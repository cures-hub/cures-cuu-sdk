import UIKit
import UIKit.UIGestureRecognizerSubclass

public class IKGestureInterceptor: NSObject, IKInterceptor {
    // inheritance from NSObject needed to implement UIGestureRecognizerDelegate
    
    // MARK: - Properties
    
    private var window: UIWindow
    private var gestureRecognizers: [IKGestureType: UIGestureRecognizer]
    
    public var interceptionDelegate: IKInterceptionDelegate
    public var gestureFactory: IKGestureFactory
    public var gestureTypes: [IKGestureType]
    
    // MARK: - Lifecycle
    
    init(window: UIWindow,
         interceptionDelegate: IKInterceptionDelegate,
         gestureFactory: IKGestureFactory,
         gestureTypes: [IKGestureType]) {
        
        self.window = window
        self.gestureRecognizers = [:]
        self.interceptionDelegate = interceptionDelegate
        self.gestureFactory = gestureFactory
        self.gestureTypes = gestureTypes
    }
    
    // MARK: - Configuration
    
    public func start() {
        for gestureType in gestureTypes {
            if gestureRecognizers[gestureType] == nil {
                configureGestureRecognizer(for: gestureType)
            }
            if let gestureRecognizer = gestureRecognizers[gestureType] {
                window.addGestureRecognizer(gestureRecognizer)
            }
        }
    }
    
    public func stop() {
        for (_, gestureRecognizer) in gestureRecognizers {
            window.removeGestureRecognizer(gestureRecognizer)
        }
    }
    
    private func configureGestureRecognizer(for type: IKGestureType) {
        switch type {
        case .tap:
            gestureRecognizers[type] = UITapGestureRecognizer()
            gestureRecognizers[type]?.addTarget(self, action: #selector(tapGestureRecognized))
            gestureRecognizers[type]?.delegate = self
        case .pinch:
            gestureRecognizers[type] = UIPinchGestureRecognizer()
            gestureRecognizers[type]?.addTarget(self, action: #selector(pinchGestureRecognized))
            gestureRecognizers[type]?.delegate = self
        case .rotation:
            gestureRecognizers[type] = UIRotationGestureRecognizer()
            gestureRecognizers[type]?.addTarget(self, action: #selector(rotationGestureRecognized))
            gestureRecognizers[type]?.delegate = self
        case .swipe:
            gestureRecognizers[type] = IKMultiDirectionSwipeGestureRecognizer()
            gestureRecognizers[type]?.addTarget(self, action: #selector(swipeGestureRecognized))
            gestureRecognizers[type]?.delegate = self
        case .pan:
            gestureRecognizers[type] = UIPanGestureRecognizer()
            gestureRecognizers[type]?.addTarget(self, action: #selector(panGestureRecognized))
            gestureRecognizers[type]?.delegate = self
        case .screenPan:
            gestureRecognizers[type] = UIScreenEdgePanGestureRecognizer()
            gestureRecognizers[type]?.addTarget(self, action: #selector(screenPanGestureRecognized))
            gestureRecognizers[type]?.delegate = self
        case .longPress:
            gestureRecognizers[type] = UILongPressGestureRecognizer()
            gestureRecognizers[type]?.addTarget(self, action: #selector(longPressRecognized))
            gestureRecognizers[type]?.delegate = self
        }
        
        // make sure not to block events for underlying views
        gestureRecognizers[type]?.cancelsTouchesInView = false
        gestureRecognizers[type]?.delaysTouchesBegan = false
        gestureRecognizers[type]?.delaysTouchesEnded = false
    }

}

// MARK: - UIGestureRecognizer callback
extension IKGestureInterceptor {

    @objc func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        let gesture = gestureFactory.gesture(from: sender)
        let characteristics = gestureFactory.characteristics(from: gesture)
        let crumb = gestureFactory.crumb(with: characteristics, title: gesture.title)
        interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
    }
    
    @objc func pinchGestureRecognized(_ sender: UIPinchGestureRecognizer) {
        let gesture = gestureFactory.gesture(from: sender)
        let characteristics = gestureFactory.characteristics(from: gesture)
        let crumb = gestureFactory.crumb(with: characteristics, title: gesture.title)
        interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
    }
    
    @objc func rotationGestureRecognized(_ sender: UIRotationGestureRecognizer) {
        let gesture = gestureFactory.gesture(from: sender)
        let characteristics = gestureFactory.characteristics(from: gesture)
        let crumb = gestureFactory.crumb(with: characteristics, title: gesture.title)
        interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
    }
    
    @objc func swipeGestureRecognized(_ sender: UISwipeGestureRecognizer) {
        let gesture = gestureFactory.gesture(from: sender)
        let characteristics = gestureFactory.characteristics(from: gesture)
        let crumb = gestureFactory.crumb(with: characteristics, title: gesture.title)
        interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
    }
    
    @objc func panGestureRecognized(_ sender: UIPanGestureRecognizer) {
        let gesture = gestureFactory.gesture(from: sender)
        let characteristics = gestureFactory.characteristics(from: gesture)
        let crumb = gestureFactory.crumb(with: characteristics, title: gesture.title)
        interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
    }
    
    @objc func screenPanGestureRecognized(_ sender: UIScreenEdgePanGestureRecognizer) {
        let gesture = gestureFactory.gesture(from: sender)
        let characteristics = gestureFactory.characteristics(from: gesture)
        let crumb = gestureFactory.crumb(with: characteristics, title: gesture.title)
        interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
    }
    
    @objc func longPressRecognized(_ sender: UIScreenEdgePanGestureRecognizer) {
        let gesture = gestureFactory.gesture(from: sender)
        let characteristics = gestureFactory.characteristics(from: gesture)
        let crumb = gestureFactory.crumb(with: characteristics, title: gesture.title)
        interceptionDelegate.interceptor(self, captured: characteristics, crumb: crumb)
    }
    
}

// MARK : - Delegate
extension IKGestureInterceptor: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
