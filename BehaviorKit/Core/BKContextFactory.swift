public protocol BKContextFactory {
    
    func predict(completion: (BKContext?) -> Void)
    
}
