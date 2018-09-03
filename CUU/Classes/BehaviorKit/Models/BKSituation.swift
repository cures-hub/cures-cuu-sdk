import Foundation

public protocol BKSituation: CustomStringConvertible {
    
    var _session: String { get set }
    var _user: String { get set }
    var timestamp: Date { get }
    
    var context: [String: BKContext] { get }
    var description: String { get }
}

extension BKSituation {
    public var description: String {
        var description = "\(Swift.type(of: self)) :: "
        
        for (_, context) in context {
            description += "\n\t \(context)"
        }
        
        return description
    }
    
    public func matches(_ template: BKSituation, exact: Bool = false) -> Bool {
        
        // if the exact flag is set, both situations need to have the same context attributes
        // otherwise only the context attributes set in the template must be matched.
        if exact && self.context.count != template.context.count {
            return false
        }
        
        for (key, templateContext) in template.context {
            guard let contextAttribute = self.context[key] else {
                return false
            }
            if contextAttribute.state != templateContext.state {
                return false
            }
        }
        
        return true
    }
}
