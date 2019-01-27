import Foundation

public protocol BKContext: CustomStringConvertible, Encodable {
       
    var type: String { get }
    var timestamp: Date { get }
    var state: String { get }
    var classProbability: [String: Double] { get }
    var description: String { get }
}

extension BKContext {
    
    public var type: String {
        return String(describing: self.type)
    }
    
    public var description: String {
        return "\(String(describing: Swift.type(of: self))) :: \(state) (\(classProbability[state] ?? 0.0))"
    }
}

