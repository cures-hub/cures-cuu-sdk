/**
 *  Protocol for handling touch data.
 **/
public protocol IKTouch: IKDataObject {
    
    /**
    *   The type of the touch.
    **/
    var type: String { set get }
    
    /**
    *   The amount of taps.
    **/
    var tapCount: Int { set get }
    
    /**
    *   The force of the touch.
    **/
    var force: Double { set get }
    
    /**
    *   The location x value of the touch.
    **/
    var locationX: Double { set get }
    
    /**
     *   The location y value of the touch.
     **/
    var locationY: Double { set get }
    
    /**
     *   The location x value of previous location of the touch.
     **/
    var previousLocationX: Double { set get }
    
    /**
     *   The location y value of previous location of the touch.
     **/
    var previousLocationY: Double { set get }

    var touchedElementTraits: String { set get }
    var touchedElementLabel: String { set get }
    var touchedElementValue: String { set get }
    var touchIsPrecise: Bool { get set }
}

extension IKTouch {
    
    public var description: String {
        return "IKTouch (\(title)) :: at (x:  \(locationX), y: \(locationY))"
    }
}
