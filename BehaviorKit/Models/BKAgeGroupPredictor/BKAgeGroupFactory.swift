import CoreML

@available(iOS 11.0, *)
public class BKAgeGroupFactory: BKContextFactory {
    
    private let model = AgeGroupContext()
    private let featureGenerator = BKAgeGroupFeatureGenerator()
    
    public init() {
        
    }
    
    private func prepare(completion: (AgeGroupContextInput?)->Void )  {
        featureGenerator.features(completion: completion)
    }
    
    private func predict(input: AgeGroupContextInput) -> AgeGroupContextOutput? {
        return try? model.prediction(input: input)
    }
    
    private func transform(output: AgeGroupContextOutput) -> BKAgeGroupContext? {
        return BKAgeGroupContext.from(output)
    }
}

@available(iOS 11.0, *)
extension BKAgeGroupFactory {
    
    
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
