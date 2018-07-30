//
//  PersonaKit.swift
//  CUU
//
//  Created by Florian Fittschen on 27.07.18.
//

class PersonaKit {

    static public let shared = PersonaKit()

    private(set) var isActive: Bool = false
    private(set) var configuration: IKConfiguration?

    public func configure(with configuration: IKConfiguration) {
        let shouldRestart = isActive
        stop()

        self.configuration = configuration

        if shouldRestart {
            start()
        }
    }


    public func start() {
        guard !isActive else { return }

        guard let configuration = configuration else {
            return
        }

        for interceptor in configuration.interceptors {
            interceptor.start()
        }

        isActive = true
    }

    public func stop() {
        guard isActive else { return }

        guard let configuration = configuration else {
            return
        }


        for interceptor in configuration.interceptors {

            interceptor.stop()
        }

        isActive = false
    }
}

extension PersonaKit: IKInterceptionDelegate {
    public func interceptor(_ interceptor: IKInterceptor, captured dataObject: IKDataObject, crumb: IKCrumb)  {
        //configuration?.storage.commit(dataObject, completion: nil)

        debugPrint(interceptor)
        debugPrint(dataObject)
        debugPrint(crumb)
    }
}
