public class BKTemplateSituation: BKSituation {
    
    public var _session: String = ""
    public var _user: String = ""
    public var timestamp: Date = Date()
    public var context: [String : BKContext] = [:]
    
    public init(withRequirements requirements: [(context: BKContext.Type, state: String)]) {
        var context: [String : BKContext] = [:]
        for (contextType, state) in requirements {
            let templateContext = BKTemplateContext(context: contextType, withState: state)
            context[templateContext.type] = templateContext
        }
        
        self.context = context
    }
    
}
