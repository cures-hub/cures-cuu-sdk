import CoreML

@available(iOS 11.0, *)
public class BKProductivenessFactory: BKContextFactory {
    
    private let model = ProdutivenessContext()
    private let featureGenerator = BKProductivenessFeatureGenerator()
    
    public init() {
        
    }
    
    private func prepare(completion: (ProdutivenessContextInput?)->Void )  {
        featureGenerator.features(completion: completion)
    }
    
    private func predict(input: ProdutivenessContextInput) -> ProdutivenessContextOutput? {
        return try? model.prediction(input: input)
    }
    
    private func transform(output: ProdutivenessContextOutput) -> BKProductivenessContext? {
        return BKProductivenessContext.from(output)
    }
}

@available(iOS 11.0, *)
extension BKProductivenessFactory {
    
    
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


