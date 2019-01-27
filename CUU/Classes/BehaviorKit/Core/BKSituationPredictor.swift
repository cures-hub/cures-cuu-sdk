public class BKSituationPredictor: BKPredictor {
    
    private var timer: Timer?
    public var predictionDelegate: BKPredictionDelegate? =  nil
    public var contextFactories: [BKContextFactory] = []
    
    public init(delegate: BKPredictionDelegate, contextFactories: [BKContextFactory]) {
        self.predictionDelegate = delegate
        self.contextFactories = contextFactories
    }
    
    public func start(withFrequency frequency: TimeInterval) {
        // be sure not to have several prediciton cycles running
        stop()
        
        let timer = Timer(fire: Date(), interval: frequency, repeats: true, block: { (timer) in
            
            self.predict() { situation in
                if let situation = situation {
                    self.predictionDelegate?.predictor(self, predicted: situation)
                }
            }
            
        })
        self.timer = timer
        // Add the timer to the current run loop.
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
    }
    
    public func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    public func predict(completion: (BKSituation?)->Void ) {
        let situation = BKDefaultSituation()
        
        let lock = NSLock()
        var finished = false
        for factory in contextFactories {
            
            factory.predict() { result in
                if let context = result {
                    lock.lock()
                    situation.context[context.type] = context
                    if !finished && situation.context.count == contextFactories.count {
                        finished = true
                        completion(situation)
                    }
                    lock.unlock()
                } else {
                    completion(nil)
                }
            }
            
        }
    }
}
