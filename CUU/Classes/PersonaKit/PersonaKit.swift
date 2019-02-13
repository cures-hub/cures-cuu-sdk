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
    private(set) var configuration: PKConfiguration?

    // DeviceInformation gets intercepted before session is active, caching values here
    private var deviceType: String?
    private var iOSVersion: String?
    private var fontScale: Double?

    private init() {
        self.currentSession = PKSession()
    }

    public func configure(with configuration: PKConfiguration) {
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
    public func interceptor(_ interceptor: IKInterceptor, captured dataObject: IKCharacteristics, crumb: IKInteraction)  {
        //configuration?.storage.commit(dataObject, completion: nil)

        if interceptor is IKAppEventInterceptor, let characteristics = dataObject as? IKAppEventCharacteristics {
            handle(appEventCharacteristics: characteristics)
        } else if interceptor is IKViewEventInterceptor, let characteristics = dataObject as? IKViewEventCharacteristics {
            handle(viewEventCharacteristics: characteristics)
        } else if interceptor is IKTouchInterceptor, let characteristics = dataObject as? IKTouchCharacteristics {
            handle(touchCharacteristics: characteristics, for: crumb)
        } else if interceptor is IKDeviceInterceptor, let characteristics = dataObject as? IKDeviceCharacteristics {
            handle(deviceCharacteristics: characteristics)
        }

//        debugPrint(interceptor)
//        debugPrint(dataObject)
//        debugPrint(crumb)
    }
}

// MARK: Session handling

extension PersonaKit {
    func handle(appEventCharacteristics characteristics: IKAppEventCharacteristics) {
        let eventType = characteristics.title

        switch eventType {
        case "didBecomeActive":
            // Overwrite currentSession.
            // Should be nil anyway. If it is not nil, the app has not been closed gracefully,
            // so the session end date would be wrong --> We discard the data
            currentSession = PKSession(cuuSessionId: characteristics.session)
            print("⏱ New session: \(currentSession!)")
        case "didResignActive":
            guard var session = currentSession else {
                preconditionFailure("⚠️: could not end session, because no currentSession was found.")
            }

            session.end = Date()
            session.deviceType = deviceType
            session.iOSVersion = iOSVersion
            session.fontScale = fontScale
            session.location = locationDetector.detectLocation()?.type.rawValue
            session.traits = PKTraitDetector.detectTraits(for: session)

            let crumb = PKSessionCrumb(session: session)
            crumb.send()
            print("📡 End and upload session: \(crumb.characteristics)")
        default: break
        }
    }

    func handle(viewEventCharacteristics characteristics: IKViewEventCharacteristics) {
        guard let viewEventType = IKViewEventType(rawValue: characteristics.title) else { return }

        switch viewEventType {
        case .didAppear:
            currentSession?.appendSceneVisit(visit: .didAppear(name: characteristics.viewControllerType, timestamp: Date()))
        case .didDisappear:
            currentSession?.appendSceneVisit(visit: .didDisappear(name: characteristics.viewControllerType, timestamp: Date()))
            return
        }
    }

    func handle(touchCharacteristics characteristics: IKTouchCharacteristics, for crumb: IKInteraction) {
        guard let touchType = IKTouchType(rawValue: characteristics.title) else { return }

        switch touchType {
        case .touchEnded:
            currentSession?.logTouch(for: characteristics, crumb: crumb)
        default:
            return
        }
    }

    func handle(deviceCharacteristics characteristics: IKDeviceCharacteristics) {

        deviceType = characteristics.deviceName
        iOSVersion = characteristics.systemVersion
        fontScale = characteristics.fontScale
    }
}

private extension IKAppEventType {
    init?(from characteristics: IKAppEventCharacteristics) {
        self.init(rawValue: characteristics.type)
    }
}
