public enum CUUStartOption: Int {
    case Features = 0
    case Interactions
    case Behavior
    case Notes
    case ThinkingAloud
    case Emotions
    case Personas
}

public class CUU {
    
    // - MARK: Attributes
    /**
     * The active configuration of CUU.
     */
    private(set) public static var configuration = CUUConfiguration()
    
    // - MARK: Attributes
    /**
     * The shared ThinkingAloudKit instance.
     */
    static let thinkingAloudKit = ThinkingAloudKit()
    
    /**
     * The shared EmotionKit instance.
     */
    static let emotionKit = EmotionKit()
    
    /**
     * The shared FeatureKit instance.
     */
    static let featureKit = FeatureKit()
    
    /**
     * The shared InteractionKit instance.
     */
    static var iKit: InteractionKit {
        return InteractionKit.shared
    }
    
    /**
     * The shared BehaviorKit instance.
     */
    static var bKit: BehaviorKit {
        return BehaviorKit.shared
    }
    
    /**
     * The shared PersonaKit instance.
     */
    static var pKit: PersonaKit {
        return PersonaKit.shared
    }
    
    /**
     * The shared CUUNetworkManager instance.
     */
    static var networkManager: CUUNetworkManager {
        return CUUNetworkManager.shared
    }
    
    /*
     * Starts CUU with the given input.
     */
    public static func start(with options:[CUUStartOption] = [.Behavior, .Notes]) {
        CUU.configuration = configuration
        
        // Check if we already asked before.
        if isCUUAllowed() {
            if let options = UserDefaults.standard.array(forKey: CUUConstants.CUUUserDefaultsKeys.optionsKey) as? [Int] {
                let values = options.map({ CUUStartOption(rawValue: $0) })
                startKits(with: values)
            } else {
                // We did not ask before, so do it now.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    guard let currentVC = CUUUtils.getTopViewController() else { return }
                    let startVC = CUUStartViewController(with: options)
                    currentVC.present(startVC, animated: true, completion: nil)
                }
            }
            
            networkManager.start()
        }
    }
    
    static func startKits(with options: [CUUStartOption?]) {
        if isCUUAllowed() {
            if options.contains(.Features) {
                FeatureKit.start()
            }
            
            if options.contains(.Interactions) {
                iKit.configure(with: configuration.interactionKitConfiguration)
                
                iKit.start()
            }
            
            if options.contains(.Behavior) {
                bKit.configure(with: configuration.behaviorKitConfiguration)
                
                bKit.start()
            }
            
            if options.contains(.Notes) {
                NoteKit.start()
            }
            
            if options.contains(.ThinkingAloud) {
                thinkingAloudKit.start()
            }
            
            if options.contains(.Emotions) {
                emotionKit.start()
            }
            
            if options.contains(.Personas) {
                pKit.configure(with: configuration.personaKitConfiguration)
                
                pKit.start()
            }
        }
    }
    
    /**
     * Stops CUU.
     */
    public static func stop() {
        FeatureKit.stop()
        iKit.stop()
        bKit.stop()
        NoteKit.stop()
        thinkingAloudKit.stop()
        emotionKit.stop()
        pKit.stop()
    }
    
    /**
     *   Open method to handle crumb saving.
     *   @param name: the name of the crumb to be created and stored
     **/
    public static func seed(name: String) {
        let actionCrumb = FKActionCrumb(name: name)
        actionCrumb.send()
        
        featureKit.handleAdditionalCrumbActionsForFeatures(with: actionCrumb)
    }
    
    static func isCUUAllowed() -> Bool {
        if let branchName = CUUConstants.branchName {
            if branchName != "master" && branchName != "develop" && branchName != "development" {
                return true
            }
        }
        return false
    }
}
