class IKDefaultGestureFactory: IKGestureFactory {
    
    func gesture(from gestureRecognizer: UITapGestureRecognizer) -> IKGesture {
        let ikGesture = IKDefaultGesture()
        return populate(ikGesture, from: gestureRecognizer)
    }
    
    func gesture(from gestureRecognizer: UIPinchGestureRecognizer) -> IKGesture {
        let ikGesture = IKDefaultGesture()
        return populate(ikGesture, from: gestureRecognizer)
    }
    
    func gesture(from gestureRecognizer: UIRotationGestureRecognizer) -> IKGesture {
        let ikGesture = IKDefaultGesture()
        return populate(ikGesture, from: gestureRecognizer)
    }
    
    func gesture(from gestureRecognizer: UISwipeGestureRecognizer) -> IKGesture {
        let ikGesture = IKDefaultGesture()
        return populate(ikGesture, from: gestureRecognizer)
    }
    
    func gesture(from gestureRecognizer: UIPanGestureRecognizer) -> IKGesture {
        let ikGesture = IKDefaultGesture()
        return populate(ikGesture, from: gestureRecognizer)
    }
    
    func gesture(from gestureRecognizer: UIScreenEdgePanGestureRecognizer) -> IKGesture {
        let ikGesture = IKDefaultGesture()
        return populate(ikGesture, from: gestureRecognizer)
    }
    
    func gesture(from gestureRecognizer: UILongPressGestureRecognizer) -> IKGesture {
        let ikGesture = IKDefaultGesture()
        return populate(ikGesture, from: gestureRecognizer)
    }
}


