public class IKDefaultConfiguration: IKConfiguration {

    public var storage: IKStorage
    
    public var interceptors: [IKInterceptor]
    
    public init(forUser user: String) {
        interceptors = IKDefaultInterceptorConfiguration.provideDefaultInterceptors()
        storage = IKCoreDataStorage()
    }
}


