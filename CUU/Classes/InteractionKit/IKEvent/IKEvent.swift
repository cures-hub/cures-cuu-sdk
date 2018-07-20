/**
 *  Protocol for events.
 **/
public protocol IKEvent: IKDataObject {
    
    /**
    *   The type of the event.
    **/
    var type: String { set get }
    
    /**
    *   Parameters of the event.
    **/
    var parameter: [String:String] { get set }
}
