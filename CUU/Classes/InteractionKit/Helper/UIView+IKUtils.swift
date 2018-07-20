public extension UIView {
    
    public var subviewCount: Int {
        if (self.subviews.count == 0) {
            return 1
        }
        
        var count = 1
        for view in self.subviews {
            count += view.subviewCount
        }
        return count
    }
    
}
