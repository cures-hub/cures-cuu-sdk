/**
 *  Protocol for the configuration of InteractionKit.
 **/
public protocol IKConfiguration {

    var interceptors: [IKInterceptor] { get }
}
