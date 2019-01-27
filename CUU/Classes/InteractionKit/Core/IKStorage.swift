import CoreData

/**
 *  Protocol for storing and retrieving InteractionKit data.
 **/
public protocol IKStorage {
    
    var persistentContainer: NSPersistentContainer { get }
    
    func commit(_ object: IKCharacteristics, completion: ((_ success: Bool, _ error: Error?) -> Void)?)
    
    func commit(_ object: IKInteraction, completion: ((_ success: Bool, _ error: Error?) -> Void)?)
    
    func fetch<T: IKCharacteristics>(_ type: T.Type, predicate: NSPredicate?, completion: (Array<IKCharacteristics>) -> Void)
    
    func fetch<T: IKInteraction>(_ type: T.Type, predicate: NSPredicate?, completion: (Array<IKInteraction>) -> Void)
}
