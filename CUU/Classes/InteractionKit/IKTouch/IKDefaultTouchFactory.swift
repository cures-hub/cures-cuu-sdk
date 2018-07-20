class IKDefaultTouchFactory: IKTouchFactory {
    
    func touch(_ capturedTouch: UITouch, type: IKTouchType) -> IKTouch {
        
        let touch = IKDefaultTouch()
        return populate(touch, capturedTouch: capturedTouch, ofType: type)
    }
    
}

