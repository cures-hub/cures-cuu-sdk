import UIKit

public class BKStatusBarWindow: UIWindow {
    
    public static let shared: BKStatusBarWindow = BKStatusBarWindow()
    public static let defaultBackgroundColor: UIColor  = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.00)
    public static let defaultTextColor: UIColor = UIColor(red:0.99, green:0.22, blue:0.31, alpha:1.00)
    
    private var textLabel: UILabel?

    public var textColor: UIColor = BKStatusBarWindow.defaultTextColor {
        didSet {
            self.textLabel?.textColor = textColor
        }
    }
    
    public var isVisible: Bool = false {
        didSet {
            isHidden = !isVisible
        }
    }
    
    private convenience init() {
        let size = CGSize(width: UIScreen.main.bounds.width, height: 20)
        let frame = CGRect(origin: .zero, size: size)
        self.init(frame: frame)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        // needed, because otherwise the application would crash
        rootViewController = UIViewController()
        
        windowLevel = UIWindow.Level.statusBar
        isUserInteractionEnabled = false
        backgroundColor = BKStatusBarWindow.defaultBackgroundColor
        initTextLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initTextLabel() {
        let label = UILabel(frame: frame)
        label.textAlignment = .center
        label.textColor = BKStatusBarWindow.defaultTextColor
        label.font = UIFont.systemFont(ofSize: 10)
        label.alpha = 0.0
        
        textLabel = label
        addSubview(label)
    }
    
    // MARK: - Public API
    
    
    
    public func show(text: String) {
        textLabel?.text = text
        textLabel?.alpha = 1.0
    }
    
    public func show(text: String, forDuration duration: TimeInterval, completion: (()->Void)? = nil) {
        show(text: text)
        let dispatchTime = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: dispatchTime, execute: {
            self.hideText()
            completion?()
        })
    }
    
    public func hideText() {
        textLabel?.alpha = 0.0
    }
    
}
