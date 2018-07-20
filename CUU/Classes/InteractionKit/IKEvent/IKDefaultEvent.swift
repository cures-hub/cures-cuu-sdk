public class IKDefaultEvent: IKEvent {
    
    public var _session: String = ""
    public var _user: String = ""
    public var startDate: Date = Date()
    public var endDate: Date = Date()
    public var title: String = ""
    public var type: String = ""
    
    public var parameter: [String:String] = [:]
    
}
