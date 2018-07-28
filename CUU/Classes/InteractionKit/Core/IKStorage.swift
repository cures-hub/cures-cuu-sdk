import CoreData

/**
 *  Protocol for storing and retrieving InteractionKit data.
 **/
public protocol IKStorage {
    
    var persistentContainer: NSPersistentContainer { get }
    
    func commit(_ object: IKCharacteristics, completion: ((_ success: Bool, _ error: Error?) -> Void)?)
    
    func fetch<T: IKCharacteristics>(_ type: T.Type, predicate: NSPredicate?, completion: (Array<IKCharacteristics>) -> Void)
    
}
