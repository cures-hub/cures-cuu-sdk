 public extension UIViewController {
    
    public var typeName: String {
        return String(describing: type(of: self))
    }
    
    public var instanceIdentifier: String {
        let pointer = Unmanaged.passUnretained(self).toOpaque()
        let address = String(describing: pointer)
        
        // TODO: hash the address before returning it
        return address
    }
    
}
