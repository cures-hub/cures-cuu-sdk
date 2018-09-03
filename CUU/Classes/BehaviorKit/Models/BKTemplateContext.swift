class BKTemplateContext: BKContext {
    
    var _session: String = ""
    var _user: String = ""
    var timestamp: Date = Date()
    var state: String = ""
    var type: String = ""
    var classProbability: [String : Double] = [:]
    
    public init(context: BKContext.Type, withState state: String) {
        self.type = String(describing: context)
        self.state = state
    }

}
