public protocol BKPredictor {
    
    var predictionDelegate: BKPredictionDelegate? {get set}
    var contextFactories: [BKContextFactory] { get set }
    
    func start(withFrequency frequency: TimeInterval)
    func stop()
    func predict(completion: (BKSituation?)->Void )
}

