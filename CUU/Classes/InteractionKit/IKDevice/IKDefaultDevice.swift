public class IKDefaultDevice: IKDevice {
    
    public var _session: String = CUUSessionManager.sharedManager.currentSession
    public var _user: String = CUUUserManager.sharedManager.userId
    public var startDate: Date = Date()
    public var endDate: Date = Date()
    public var title: String = ""
    public var commonDeviceName: String = ""
    public var deviceName: String = ""
    public var deviceModel: String = ""
    public var systemName: String = ""
    public var systemVersion: String = ""
    public var screenSize: Double = 0.0
    public var screenScale: Double = 0.0
    public var screenWidth: Double = 0.0
    public var screenHeight: Double = 0.0
    public var screenNativeWidth: Double = 0.0
    public var screenNativeHeight: Double = 0.0
    public var fontScale: Double = 0.0
}

