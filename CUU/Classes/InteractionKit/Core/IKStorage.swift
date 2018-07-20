/**
 *  Protocol for storing and retrieving InteractionKit data.
 **/
public protocol IKStorage {
    
    func commit(_ object: IKDataObject, completion: ((_ success: Bool, _ error: Error?) -> Void)?)
    
    func fetch<T: IKDataObject>(_ type: T.Type, predicate: NSPredicate?, completion: (Array<IKDataObject>)->Void)
}
