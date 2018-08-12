//
//  PKSession.swift
//  CUU
//
//  Created by Florian Fittschen on 01.08.18.
//

import Foundation

struct PKSession: Codable {
    struct SceneVisit: Codable {
        let name: String
        let date: Date
    }

    /// The unique identifier of the session.
    let sessionId: String

    /// The start of the session.
    let start: Date

    /// The end of the session.
    var end: Date?

    var deviceType: String?

    private var touchDates: [Date] = []
    private var visitedScenes: [SceneVisit] = []
    private var timeOnScenes: [Double] = []

    init(sessionId: String = CUUSessionManager.sharedManager.currentSession, start: Date, end: Date? = nil) {
        self.sessionId = sessionId
        self.start = start
        self.end = end
    }

    mutating func appendSceneVisit(visit: SceneVisit) {
        guard !visitedScenes.isEmpty, let lastScene = visitedScenes.last else {
            // If empty, just append and return
            visitedScenes.append(visit)
            return
        }
        visitedScenes.append(visit)
        let timeDifference = visit.date.timeIntervalSinceReferenceDate - lastScene.date.timeIntervalSinceReferenceDate
        print("Time on scene '\(lastScene.name)': \(timeDifference) seconds.")
        timeOnScenes.append(timeDifference)
    }

    mutating func logTouch(crumb: IKTouchCrumb) {
        touchDates.append(crumb.timestamp)
    }
}

// MARK: Computed Properties

extension PKSession {
    var duration: Measurement<UnitDuration>? {
        guard let end = end else { return nil }
        let seconds = end.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
        return Measurement<UnitDuration>(value: seconds, unit: .seconds)
    }

    var durationInSeconds: Double? {
        return duration?.value
    }

    var mostVisitedScene: String? {
        guard !visitedScenes.isEmpty else { return nil }
        let scenes = visitedScenes.map { $0.name }
        return scenes.histogram.max(by: { $0.value < $1.value })?.key
    }

    var averageTimeOnScene: Double? {
        guard !timeOnScenes.isEmpty else { return nil }
        return timeOnScenes.average
    }

    var numberOfTouches: Int {
        return touchDates.count
    }

    var averageTimeBetweenTouches: Double? {
        guard touchDates.count >= 2 else { return nil }
        let timeBetweenTouches = zip(touchDates, Array(touchDates.dropFirst())).map { (lhs, rhs) -> Double? in
            let difference = rhs.timeIntervalSinceReferenceDate - lhs.timeIntervalSinceReferenceDate
            // We don't want to include touches that happen after one minute, since it probably is a new touch stream
            guard difference < 60 else { return nil }
            return difference
        }.compactMap { $0 }
        return timeBetweenTouches.average
    }
}

extension PKSession: Identifiable {
    static let idKey = \PKSession.sessionId
}
