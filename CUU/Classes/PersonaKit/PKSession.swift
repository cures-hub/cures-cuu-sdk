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
            let appearances = sceneVisits.filter { visit in
                if case .didAppear = visit {
                    return true
                } else {
                    return false
                }
            }
            guard let lastAppearance = appearances.last(where: { $0.name == name }) else { return }
            let duration = timestamp.timeIntervalSinceReferenceDate - lastAppearance.timestamp.timeIntervalSinceReferenceDate
            updateStatisticsForScene(with: name, duration: duration)
        }
    }

    mutating func logTouch(for characteristics: IKTouchCharacteristics, crumb: IKInteraction) {
        touchDates.append(crumb.timestamp)
        touchesPrecise.append(characteristics.touchIsPrecise)
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
        let targetNumberOfVisits = 8
        let timePeriod: Duration = 30
        let appearances = sceneVisits.filter { $0.isDidAppear }
        guard appearances.count > targetNumberOfVisits else {
            return false
        }

        var slices: [ArraySlice<PKSceneVisit>] = []

        for (offset, element) in appearances.enumerated() {
            let currentSlice = appearances[offset..<appearances.count]
            let sliceOfSlice = currentSlice.prefix(while: { $0.timestamp < element.timestamp.addingTimeInterval(timePeriod)})
            if sliceOfSlice.count >= targetNumberOfVisits {
                slices.append(sliceOfSlice)
            }
        }

        // User visited \(targetNumberOfVisits) scenes in a time period of \(timePeriod) seconds anywhere during this session
        return !slices.isEmpty
    }

    var isConfused: Bool {
        let targetNumberOfVisits = 5
        let targetDuration: Duration = 2

        guard sceneStatistics.count > targetNumberOfVisits else {
            return false
        }
        let allDurations = sceneStatistics.values.flatMap { $0 }
        let numberOfShortVisits = allDurations.count(where: { $0 < targetDuration })

        // TODO: examine if we want to use absolute number (> 5) or percentage of all visits
        return numberOfShortVisits > targetNumberOfVisits
    }

    var isFearless: Bool {
        let alertStatistics = sceneStatistics.filter { (key: String, value: [Duration]) -> Bool in
            key.lowercased().contains("alert")
        }
        guard !alertStatistics.isEmpty else {
            return false
        }
        let alertDurations = alertStatistics.values.flatMap { $0 }
        let numberOfShortVisits = alertDurations.count(where: { $0 < 2 }) // Everything below 2 seconds is probably not read

        return numberOfShortVisits > 0
    }
}

extension PKSession: Identifiable {
    static let idKey = \PKSession.sessionId
}
