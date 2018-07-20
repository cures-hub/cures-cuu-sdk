/**
 *  Protocol for InteractionKit sensor data.
 **/
public protocol IKSensor: IKDataObject {
    
    /**
    *   The type of the sensor.
    **/
    var type: String { set get }

    /**
    *   The x value of the sensor data.
    **/
    var x: Double { get set }
    
    /**
     *   The y value of the sensor data.
     **/
    var y: Double { get set }
    
    /**
     *   The z value of the sensor data.
     **/
    var z: Double { get set }
    
}
