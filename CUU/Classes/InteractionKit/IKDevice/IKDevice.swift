/**
 *  Protocol for storing Device data.
 **/
public protocol IKDevice: IKDataObject {
    
    /**
    *   The common name of the device.
    **/
    var commonDeviceName: String { get set }
    
    /**
    *   The name of the device.
    **/
    var deviceName: String { get set }
    
    /**
    *   The model of the device.
    **/
    var deviceModel: String { get set }
    
    /**
    *   The name of the system.
    **/
    var systemName: String { get set }
    
    /**
    *   The version of the system.
    **/
    var systemVersion: String { get set }
    
    /**
    *   The size of the device's screen.
    **/
    var screenSize: Double { get set }
    
    /**
    *   The scale of the device's screen.
    **/
    var screenScale: Double { get set }
    
    /**
     *   The width of the device's screen.
     **/
    var screenWidth: Double { get set }
    
    /**
     *   The height of the device's screen.
     **/
    var screenHeight: Double { get set }
    
    /**
     *   The native width of the device's screen.
     **/
    var screenNativeWidth: Double { get set }
    
    /**
     *   The native height of the device's screen.
     **/
    var screenNativeHeight: Double { get set }

    var fontScale: Double { get set }
}
