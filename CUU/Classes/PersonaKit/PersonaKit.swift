//
//  PersonaKit.swift
//  CUU
//
//  Created by Florian Fittschen on 27.07.18.
//

import Foundation

public class PersonaKit {

    static public let shared = PersonaKit()

    private let sessionStore = UserDefaultsStore<PKSession>(uniqueIdentifier: "PKSession")
    private let statisticsStore = UserDefaultsStore<PKStatistics>(uniqueIdentifier: "PKStatistics")
    private(set) var isActive: Bool = false
    private(set) var configuration: IKConfiguration?

    private init() {
        if sessionStore?.allObjects().count == 0 {
            let initialSession = PKSession(start: Date())
            try! sessionStore?.save(initialSession)
            print("⚠️ No session on init(). Inserting \(initialSession)")
        }
        if statisticsStore?.allObjects().count == 0 {
            guard let initialStatistics = PKStatistics() else {
                preconditionFailure("Could not initialize PKStatistics. Maybe the `identifierForVendor` is nil?")
            }
            try! statisticsStore?.save(initialStatistics)
            print("⚠️ No statistics on init(). Inserting \(initialStatistics)")
        }
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

        debugPrint(interceptor)
        debugPrint(dataObject)
        debugPrint(crumb)
    }
}

// MARK: Session handling

extension PersonaKit {
    func handle(appEventCrumb crumb: IKAppEventCrumb) {
        guard let eventType = IKAppEventType(from: crumb) else {
            return
        }

        switch eventType {
        case .didBecomeActive:
            guard let allSessions = sessionStore?.allObjects() else {
                preconditionFailure("Cannot retrieve objects from store. Should return array of 0 or more elements.")
            }

            if allSessions.count > 1 {
                print("⚠️: There are too many sessions stored! Removing all old sessions.")
                sessionStore?.deleteAll()
            }

            if let oldSession = allSessions.first, allSessions.count == 1 {
                if oldSession.sessionId == crumb.sessionId {
                    // Old session continues --> deleting end date
                    let updatedSession = updateSessionEndDate(oldSession: oldSession, endDate: nil)
                    print("⏱ Continue session: \(updatedSession)")
                    return
                } else {
                    var mutableOldSession = oldSession
                    if mutableOldSession.end == nil {
                        // App was not properly terminated --> Session end is missing
                        // Setting the current date as end of last session
                        // TODO: Determine if this results in dirty data that states very long session durations
                        mutableOldSession.end = Date()
                    }
                    let statistics = updateTotalUsageDuration(from: mutableOldSession)
                    let crumb = PKSessionCrumb(session: mutableOldSession, statistics: statistics)
                    crumb.send()
                    print("📡 Uploading session: \(mutableOldSession)")
                    sessionStore?.delete(withId: oldSession.sessionId)
                }
            }

            let session = saveNewSession(from: crumb)
            print("⏱ New session: \(session)")
        case .didResignActive:
            guard let session = sessionStore?.object(withId: crumb.sessionId) else {
                preconditionFailure("⚠️: could not end session, because no session with sessionId  of '\(crumb.sessionId)' was found.")
            }

            let endedSession = updateSessionEndDate(oldSession: session, endDate: Date())
            print("⏱ End session: \(endedSession)")
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
            guard var session = sessionStore?.allObjects().first else { return }
            session.appendSceneVisit(visit: PKSceneVisit(name: characteristics.viewControllerType, date: Date()))

            // Update Session
            try! sessionStore?.save(session)
        case .didDisappear:
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
            guard var session = sessionStore?.allObjects().first else { return }
            session.logTouch(crumb: crumb)

            // Update Session
            try! sessionStore?.save(session)
        default:
            return
        }
    }

    func handle(deviceCrumb crumb: IKDeviceCrumb) {
        guard let characteristics = crumb.characteristics as? IKDeviceCharacteristics else {
            return
        }

        guard var session = sessionStore?.allObjects().first else { return }
        session.deviceType = characteristics.deviceName
        session.iOSVersion = characteristics.systemVersion
        session.fontScale = characteristics.fontScale

        // Update Session
        try! sessionStore?.save(session)
    }

    @discardableResult
    func saveNewSession(from crumb: IKAppEventCrumb) -> PKSession {
        let session = PKSession(sessionId: crumb.sessionId, start: Date())
        try! sessionStore?.save(session)
        return session
    }

    @discardableResult
    func updateSessionEndDate(oldSession: PKSession, endDate: Date?) -> PKSession {
        var mutableSession = oldSession
        mutableSession.end = endDate
        try! sessionStore?.save(mutableSession)
        return mutableSession
    }

    @discardableResult
    func updateTotalUsageDuration(from session: PKSession) -> PKStatistics {
        guard var statistics = statisticsStore?.allObjects().first else {
            preconditionFailure("There should always be a PKStatistics object in the store")
        }
        guard let duration = session.durationInSeconds else {
            preconditionFailure("Cannot calculate session duration without session end")
        }

        statistics.totalUsageDuration += duration

        // Update Session
        try! statisticsStore?.save(statistics)
        return statistics
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
