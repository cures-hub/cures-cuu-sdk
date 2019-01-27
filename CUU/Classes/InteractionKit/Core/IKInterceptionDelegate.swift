/**
 *  Protocol for capturing data of the InteractionKit interceptors.
 **/
public protocol IKInterceptionDelegate {
    
    func interceptor(_ interceptor: IKInterceptor, captured dataObject: IKCharacteristics, crumb: IKInteraction)
    
}

