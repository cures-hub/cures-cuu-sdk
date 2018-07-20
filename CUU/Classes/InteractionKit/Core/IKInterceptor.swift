import Foundation

/**
 *  Protocol for the InteractionKit interceptors.
 **/
public protocol IKInterceptor {
    
    var interceptionDelegate: IKInterceptionDelegate { get set }
        
    func start()
    func stop()
    
}
