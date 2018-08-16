//
//  PKSession.swift
//  CUU
//
//  Created by Florian Fittschen on 01.08.18.
//

import Foundation

typealias Duration = TimeInterval

struct PKSession {

    let sessionId: String
    let cuuSessionId: String
    let start: Date

    var end: Date?
    var deviceType: String?
    var iOSVersion: String?
    var fontScale: Double?
    
    var location: String?
    var traits: [PKTraitType] = []

    private var touchDates: [Date] = []
    private var touchesPrecise: [Bool] = []
    private var sceneVisits: [PKSceneVisit] = []
    private var sceneStatistics: [String: [Duration]] = [:]

    init(sessionId: String = UUID().uuidString,
         cuuSessionId: String = CUUSessionManager.sharedManager.currentSession,
         start: Date = Date(),
         end: Date? = nil) {
        self.sessionId = sessionId
        self.cuuSessionId = cuuSessionId
        self.start = start
        self.end = end
    }

    mutating func appendSceneVisit(visit: PKSceneVisit) {
        sceneVisits.append(visit)

        switch visit {
        case .didAppear:
            return
        case .didDisappear(let name, let timestamp):
            guard let lastAppearance = sceneVisits.last(where: { $0.name == name }) else { return }
            let duration = timestamp.timeIntervalSinceReferenceDate - lastAppearance.timestamp.timeIntervalSinceReferenceDate
            print("[ViewEvent] Time on '\(name)': \(duration) seconds")
            updateStatisticsForScene(with: name, duration: duration)
        }
    }

    mutating func logTouch(crumb: IKTouchCrumb) {
        touchDates.append(crumb.timestamp)
        if let characteristics = crumb.characteristics as? IKTouchCharacteristics {
            touchesPrecise.append(characteristics.touchIsPrecise)
        }
    }

    private mutating func updateStatisticsForScene(with name: String, duration: Duration) {
        if !sceneStatistics.keys.contains(name) {
            sceneStatistics[name] = []
        }

        sceneStatistics[name]?.append(duration)
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
        guard !sceneStatistics.isEmpty else { return nil }
        let scene = sceneStatistics.max { $0.value.count < $1.value.count }
        return scene?.key
    }

    var averageTimeOnMostVisitedScene: Double? {
        guard let mostVisitedScene = mostVisitedScene,
            let durations = sceneStatistics[mostVisitedScene] else { return nil }
        return durations.average
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

    var percentageOfPreciseTouches: Double {
        guard let numberOfPreciseTouches = touchesPrecise.histogram[true] else {
            return 0.0
        }
        return Double(numberOfPreciseTouches) / Double(touchesPrecise.count)
    }

    var isHasty: Bool {
        guard let durationInSeconds = durationInSeconds, numberOfTouches > 3 else {
            // Only evaluate "real", ended sessions that have at least 3 touches
            return false
        }

        return durationInSeconds < 10
    }

    var isAdventurous: Bool {
        guard sceneStatistics.count > 10 else {
            return false
        }
        let averageDurations = sceneStatistics.mapValues({ $0.average }).values
        let numberOfShortVisits = averageDurations.count(where: { $0 < 5 })

        // TODO: examine if we want to use absolute number (> 10) or percentage of all visits
        return numberOfShortVisits > 10
    }

    var isFearless: Bool {
        let alertStatistics = sceneStatistics.filter { (key: String, value: [Duration]) -> Bool in
            key.lowercased().contains("alert")
        }
        let averagedDuration = sceneStatistics.mapValues({ $0.average })

        // Everything below 2 seconds is probably not read
        let numberOfShortVisits = averagedDuration.count(where: { $0.value < 2 })

        return alertStatistics.count == numberOfShortVisits
    }
}

extension PKSession: Identifiable {
    static let idKey = \PKSession.sessionId
}
