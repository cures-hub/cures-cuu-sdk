//
//  PersonaKit.swift
//  CUU
//
//  Created by Florian Fittschen on 27.07.18.
//

import Foundation

public class PersonaKit {

    static public let shared = PersonaKit()

    private let locationDetector = PKLocationDetector()
    private var currentSession: PKSession?
    private(set) var isActive: Bool = false
    private(set) var configuration: IKConfiguration?

    // DeviceInformation gets intercepted before session is active, caching values here
    private var deviceType: String?
    private var iOSVersion: String?
    private var fontScale: Double?

    private init() {
        self.currentSession = PKSession()
    }

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
        guard let configuration = configuration else { return }

        for interceptor in configuration.interceptors {
            interceptor.start()
        }

        isActive = true
    }

    public func stop() {
        guard isActive else { return }
        guard let configuration = configuration else { return }

        for interceptor in configuration.interceptors {
            interceptor.stop()
        }

        isActive = false
    }
}

extension PersonaKit: IKInterceptionDelegate {
    public func interceptor(_ interceptor: IKInterceptor, captured dataObject: IKDataObject, crumb: IKCrumb)  {
        //configuration?.storage.commit(dataObject, completion: nil)

        if interceptor is IKAppEventInterceptor, let crumb = crumb as? IKAppEventCrumb {
            handle(appEventCrumb: crumb)
        } else if interceptor is IKViewEventInterceptor, let crumb = crumb as? IKViewEventCrumb {
            handle(viewEventCrumb: crumb)
        } else if interceptor is IKTouchInterceptor, let crumb = crumb as? IKTouchCrumb {
            handle(touchCrumb: crumb)
        } else if interceptor is IKDeviceInterceptor, let crumb = crumb as? IKDeviceCrumb {
            handle(deviceCrumb: crumb)
        }

//        debugPrint(interceptor)
//        debugPrint(dataObject)
//        debugPrint(crumb)
    }
}

// MARK: Session handling

extension PersonaKit {
    func handle(appEventCrumb crumb: IKAppEventCrumb) {
        guard let eventType = IKAppEventType(from: crumb) else { return }

        switch eventType {
        case .didBecomeActive:
            // Overwrite currentSession.
            // Should be nil anyway. If it is not nil, the app has not been closed gracefully,
            // so the session end date would be wrong --> We discard the data
            currentSession = PKSession(cuuSessionId: crumb.sessionId)
            print("⏱ New session: \(currentSession!)")
        case .didResignActive:
            guard var session = currentSession else {
                preconditionFailure("⚠️: could not end session, because no currentSession was found.")
            }

            session.end = Date()
            session.deviceType = deviceType
            session.iOSVersion = iOSVersion
            session.fontScale = fontScale
            session.location = locationDetector.detectLocation()?.type.rawValue

            let crumb = PKSessionCrumb(session: session)
            crumb.send()
            print("📡 End and upload session: \(crumb.characteristics)")
        default: break
        }
    }

    func handle(viewEventCrumb crumb: IKViewEventCrumb) {
        guard let characteristics = crumb.characteristics as? IKViewEventCharacteristics,
            let viewEventType = IKViewEventType(rawValue: characteristics.title) else {
            return
        }

        switch viewEventType {
        case .didAppear:
            currentSession?.appendSceneVisit(visit: .didAppear(name: characteristics.viewControllerType, timestamp: Date()))
            print("[ViewEvent.didAppear] \(characteristics.viewControllerType)")
        case .didDisappear:
            currentSession?.appendSceneVisit(visit: .didDisappear(name: characteristics.viewControllerType, timestamp: Date()))
            print("[ViewEvent.didDisappear] \(characteristics.viewControllerType)")
            return
        }
    }

    func handle(touchCrumb crumb: IKTouchCrumb) {
        guard let characteristics = crumb.characteristics as? IKTouchCharacteristics,
            let touchType = IKTouchType(rawValue: characteristics.title) else {
                return
        }

        switch touchType {
        case .touchEnded:
            currentSession?.logTouch(crumb: crumb)
        default:
            return
        }
    }

    func handle(deviceCrumb crumb: IKDeviceCrumb) {
        guard let characteristics = crumb.characteristics as? IKDeviceCharacteristics else { return }

        deviceType = characteristics.deviceName
        iOSVersion = characteristics.systemVersion
        fontScale = characteristics.fontScale
    }
}

private extension IKAppEventType {
    init?(from crumb: IKAppEventCrumb) {
        guard let typeString = (crumb.characteristics as? IKAppEventCharacteristics)?.interactionType else {
            return nil
        }
        self.init(rawValue: typeString)
    }
}
