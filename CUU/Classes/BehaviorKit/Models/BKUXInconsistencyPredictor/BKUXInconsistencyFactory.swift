import CoreML

@available(iOS 11.0, *)
public class BKUXInconsistencyFactory: BKContextFactory {
    
    private let model = UXInconsistencyContext()
    private let featureGenerator = BKUXInconsistencyFeatureGenerator()
    
    public init() {
        
    }
    
    private func prepare(completion: (UXInconsistencyContextInput?)->Void )  {
        featureGenerator.features(completion: completion)
    }
    
    private func predict(input: UXInconsistencyContextInput) -> UXInconsistencyContextOutput? {
        return try? model.prediction(input: input)
    }
    
    private func transform(output: UXInconsistencyContextOutput) -> BKUXInconsistencyContext? {
        return BKUXInconsistencyContext.from(output)
    }
}

@available(iOS 11.0, *)
extension BKUXInconsistencyFactory {
    
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



