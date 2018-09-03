import CoreML

@available(iOS 11.0, *)
public class BKGenderFactory: BKContextFactory {
    
    private let model = GenderContext()
    private let featureGenerator = BKGenderFeatureGenerator()
    
    public init() {
        
    }
    
    private func prepare(completion: (GenderContextInput?)->Void )  {
        featureGenerator.features(completion: completion)
    }
    
    private func predict(input: GenderContextInput) -> GenderContextOutput? {
        return try? model.prediction(input: input)
    }
    
    private func transform(output: GenderContextOutput) -> BKGenderContext? {
        return BKGenderContext.from(output)
    }
}

@available(iOS 11.0, *)
extension BKGenderFactory {
    
    
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


