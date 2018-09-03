import CoreML

@available(iOS 11.0, *)
public class BKOrientationFactory: BKContextFactory {

    private let model = OrientationContext()
    private let featureGenerator = BKOrientationFeatureGenerator()

    public init() {
        
    }
    
    private func prepare(completion: (OrientationContextInput?)->Void )  {
        featureGenerator.features(completion: completion)
    }
    
    private func predict(input: OrientationContextInput) -> OrientationContextOutput? {
        return try? model.prediction(input: input)
    }
    
    private func transform(output: OrientationContextOutput) -> BKOrientationContext? {
        return BKOrientationContext.from(output)
    }
}

@available(iOS 11.0, *)
extension BKOrientationFactory {
    
    
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

