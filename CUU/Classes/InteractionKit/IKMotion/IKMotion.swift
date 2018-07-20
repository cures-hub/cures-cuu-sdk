/**
*   Protocol for motions.
**/
public protocol IKMotion: IKDataObject{
    /**
    *   The type of the motion.
    **/
    var type: String { set get }
    
}
