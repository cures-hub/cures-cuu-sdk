import CoreML

@available(iOS 11.0, *)
public class BKMissingInteractionElementFactory: BKContextFactory {
    
    private let model = MissingInteractionElementContext()
    private let featureGenerator = BKMissingInteractionElementFeatureGenerator()
    
    public init() {
        
    }
    
    private func prepare(completion: (MissingInteractionElementContextInput?)->Void )  {
        featureGenerator.features(completion: completion)
    }
    
    private func predict(input: MissingInteractionElementContextInput) -> MissingInteractionElementContextOutput? {
        return try? model.prediction(input: input)
    }
    
    private func transform(output: MissingInteractionElementContextOutput) -> BKMissingInteractionElementContext? {
        return BKMissingInteractionElementContext.from(output)
    }
}

@available(iOS 11.0, *)
extension BKMissingInteractionElementFactory {
    
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




