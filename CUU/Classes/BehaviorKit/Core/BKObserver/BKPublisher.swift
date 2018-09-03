public protocol BKPublisher {
    
    var previousSituation: BKSituation? { get }
    var currentSituation: BKSituation? { get }
    var subscriptions: [(subscriber: BKSubscriber?, strategy: BKSubscriptionStrategy)] { get }
    
    func notify()
    func subscribe(subscriber: BKSubscriber, with strategy: BKSubscriptionStrategy)
    func unsubscribe(subscriber: BKSubscriber)
    func set(subscriptions: [(subscriber: BKSubscriber?, strategy: BKSubscriptionStrategy)])

}

extension BKPublisher {
    
    public func subscribe(subscriber: BKSubscriber, with strategy: BKSubscriptionStrategy) {
        var subscriptions = self.subscriptions
        subscriptions.append((subscriber: subscriber, strategy: strategy))
        set(subscriptions: subscriptions)
    }
    
    public func unsubscribe(subscriber: BKSubscriber) {
        var subscriptions: [(subscriber: BKSubscriber?, strategy: BKSubscriptionStrategy)] = []
        
        for subscription in self.subscriptions {
            if subscription.subscriber == nil {
                continue
            }
            if let existingSubscriber = subscription.subscriber,
                 ObjectIdentifier(existingSubscriber as AnyObject) ==  ObjectIdentifier(subscriber as AnyObject) {
                continue
            }
            subscriptions.append(subscription)
        }
        
        set(subscriptions: subscriptions)
    }
    
    public func notify() {
        
        guard let situation = currentSituation else {
            return
        }
        
        for (subscriber, strategy) in subscriptions {
            
            let situationHasChanged = previousSituation == nil || !situation.matches(previousSituation!, exact: true)
            
            var shouldNotify = true
            if case let BKSubscriptionStrategy.match(templateSituation) = strategy {
                shouldNotify = situation.matches(templateSituation, exact: false)
            }

            if shouldNotify {
                subscriber?.update(situation: situation)
                if situationHasChanged {
                    subscriber?.update(changedSituation: situation)
                }
            }
        }
        
    }
    
}
