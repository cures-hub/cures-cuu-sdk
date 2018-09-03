import CoreML

@available(iOS 11.0, *)
public class BKSmartphoneExperienceFactory: BKContextFactory {
    
    private let model = SmartphoneExperienceContext()
    private let featureGenerator = BKSmartphoneExperienceFeatureGenerator()
    
    public init() {
        
    }
    
    private func prepare(completion: (SmartphoneExperienceContextInput?)->Void )  {
        featureGenerator.features(completion: completion)
    }
    
    private func predict(input: SmartphoneExperienceContextInput) -> SmartphoneExperienceContextOutput? {
        return try? model.prediction(input: input)
    }
    
    private func transform(output: SmartphoneExperienceContextOutput) -> BKSmartphoneExperienceContext? {
        return BKSmartphoneExperienceContext.from(output)
    }
}

@available(iOS 11.0, *)
extension BKSmartphoneExperienceFactory {
    
    
    public func predict(completion: (BKContext?) -> Void) {
        
        prepare() { input in
            guard let input = input, let output = predict(input: input) else {
                completion(nil)
                return
            }
            completion(transform(output: output))
        }
        
    }
    
}



