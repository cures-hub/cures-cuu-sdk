public protocol BKStorage {
    
    func commit(_ object: BKSituation, completion: ((_ success: Bool, _ error: Error?) -> Void)?)
}

