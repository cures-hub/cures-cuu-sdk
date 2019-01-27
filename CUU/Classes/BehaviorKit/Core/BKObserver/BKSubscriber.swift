public protocol BKSubscriber {
    
    func update(situation: BKSituation)
    func update(changedSituation: BKSituation)
}

extension BKSubscriber {
    public func update(situation: BKSituation) {
        // do nothing
    }
    
    public func update(changedSituation: BKSituation) {
        // do nothing
    }
}


