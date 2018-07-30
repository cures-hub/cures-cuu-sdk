public class CUU {
    
    // - MARK: Attributes
    /**
     * The active configuration of CUU.
     */
    private(set) public static var configuration = CUUConfiguration()
    
    /**
     * The shared InteractionKit instance.
     */
    public static var iKit: InteractionKit {
        return InteractionKit.shared
    }

    static var personaKit: PersonaKit {
        return PersonaKit.shared
    }
    
    // - MARK: Methods
    /**
     * Sets the active CUUConfiguration.
     */
    /*public static func set(configuration: CUUConfiguration) {
        CUU.configuration = configuration
        
        iKit.configure(with: configuration.interactionKitConfiguration)
    }*/
    
    /**
     * Starts InteractionKit.
     */
    public static func start() {
        CUU.configuration = configuration
        
        // Check if we already asked before.
        if let options = UserDefaults.standard.array(forKey: CUUConstants.CUUUserDefaultsKeys.optionsKey) as? [Int] {
            let values = options.map({ CUUStartOption(rawValue: $0) })
            startKits(with: values)
        } else {
            // We did not ask before, so do it now.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                guard let currentVC = CUUUtils.getTopViewController() else { return }
                let startVC = CUUStartViewController()
                currentVC.present(startVC, animated: true, completion: nil)
            }
        }
    }
    
    static func startKits(with options: [CUUStartOption?]) {
        if options.contains(.Features) {
            FeatureKit.start()
        }
        
        if options.contains(.Interactions) {
            iKit.configure(with: configuration.interactionKitConfiguration)
            
            iKit.start()
        }

        if options.contains(.Personas) {
            personaKit.configure(with: configuration.personaKitConfiguration)
            PersonaKit.shared.start()
        }
    }
    
    /**
     * Stops InteractionKit.
     */
    public static func stop() {
        FeatureKit.stop()
        iKit.stop()
        PersonaKit.shared.stop()
    }
}
