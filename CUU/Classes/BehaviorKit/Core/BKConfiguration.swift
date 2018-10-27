public protocol BKConfiguration {
    
    var storage: BKStorage { get }
    var predictor: BKPredictor? { get }
    var frequency: TimeInterval {get }
    
}
