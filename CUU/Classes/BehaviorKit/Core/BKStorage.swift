import CoreData

public protocol BKStorage {
    
    var persistentContainer: NSPersistentContainer { get }
    
    func commit(_ object: BKEncodedData, completion: ((_ success: Bool, _ error: Error?) -> Void)?)
    
    func fetch(predicate: NSPredicate?, completion: (Array<BKEncodedData>) -> Void)
}

