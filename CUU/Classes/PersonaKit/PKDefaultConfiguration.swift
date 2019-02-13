//
//  PKDefaultConfiguration.swift
//  CUU
//
//  Created by Florian Fittschen on 30.07.18.
//

import Foundation

class PKDefaultConfiguration: PKConfiguration {
    var storage: PKStorage

    var interceptors: [IKInterceptor]

    init(interceptors: [IKInterceptor]? = nil) {
        self.interceptors = interceptors ?? PKDefaultConfiguration.defaultInterceptors
        self.storage = PKDefaultStorage()
    }

    static var defaultInterceptors: [IKInterceptor] {
        let appDelegate = UIApplication.shared.delegate as! IKAppDelegate

        return [
            IKViewEventInterceptor(interceptionDelegate: PersonaKit.shared, viewEventFactory: IKDefaultViewEventFactory()),
            IKAppEventInterceptor(interceptionDelegate: PersonaKit.shared, appEventFactory: IKDefaultAppEventFactory()),
            IKDeviceInterceptor(interceptionDelegate: PersonaKit.shared, deviceFactory: IKDefaultDeviceFactory()),
            IKTouchInterceptor(window: appDelegate.window!, interceptionDelegate: PersonaKit.shared, touchFactory: IKDefaultTouchFactory())
        ]
    }
}
