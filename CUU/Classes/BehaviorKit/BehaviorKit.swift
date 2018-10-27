import UIKit

public class BehaviorKit {

    static public let shared = BehaviorKit()
    
    private(set) var isActive: Bool = false
    private(set) var configuration: BKConfiguration?
    
    public private(set) var currentSituation: BKSituation?
    public private(set) var previousSituation: BKSituation?
    public private(set) var subscriptions: [(subscriber: BKSubscriber?, strategy: BKSubscriptionStrategy)] = []
    
    private init() {
        
    }
    
    public func configure(with configuration: BKConfiguration) {
        let shouldRestart = isActive
        if isActive {
            stop()
        }
        
        self.configuration = configuration
        
        if shouldRestart {
            start()
        }
    }
    
    
    public func start() {
        if isActive {
            return
        }
        
        guard let configuration = configuration, let predictor = configuration.predictor else {
            return
        }

        predictor.start(withFrequency: configuration.frequency)
        
        isActive = true
    }
    
    public func stop() {
        if !isActive {
            return
        }
        
        guard let configuration = configuration, let predictor = configuration.predictor else {
            return
        }
        
        predictor.stop()
        
        isActive = false
    }
    
    public func fetch(predicate: NSPredicate?, completion: (Array<BKEncodedData>)->Void) {
        
        if let storage = configuration?.storage {
            storage.fetch(predicate: predicate, completion: completion)
        } else{
            completion([])
        }
    }
}

extension BehaviorKit: BKPublisher {
    
    public func set(subscriptions: [(subscriber: BKSubscriber?, strategy: BKSubscriptionStrategy)]) {
        self.subscriptions = subscriptions
    }
    
}

extension BehaviorKit: BKPredictionDelegate {
    public func predictor(_ predictor: BKPredictor, predicted situation: BKSituation) {
        let storage = configuration!.storage
        let context = storage.persistentContainer.viewContext
        
        let transferObject = BKTransferObject(situation: situation)
        let dataObject = BKEncodedData(context: context, situation: transferObject)
                 
        storage.commit(dataObject, completion: nil)
        
        previousSituation = currentSituation
        currentSituation = situation
        notify()
    }
}
