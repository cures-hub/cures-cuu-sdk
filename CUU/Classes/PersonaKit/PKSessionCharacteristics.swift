//
//  PKSessionCharacteristics.swift
//  CUU
//
//  Created by Florian Fittschen on 04.08.18.
//

import Foundation

class PKSessionCharacteristics: CUUCharacteristics {

    // MARK: - Properties

    let sessionId: String
    let cuuSessionId: String
    let start: Date
    let end: Date

    let durationInSeconds: Duration
    let mostVisitedScene: String?
    let averageTimeOnMostVisitedScene: Duration?
    let numberOfTouches: Int
    let averageTimeBetweenTouches: Duration?
    let deviceType: String?
    let iOSVersion: String?
    let fontScale: Double?

    // MARK: - Lifecycle

    init(session: PKSession) {
        guard let end = session.end else {
            preconditionFailure("Cannot create PKSessionCharacteristics from a session without an end.")
        }

        self.sessionId = session.sessionId
        self.cuuSessionId = session.cuuSessionId
        self.start = session.start
        self.end = end
        self.durationInSeconds = end.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
        self.mostVisitedScene = session.mostVisitedScene
        self.averageTimeOnMostVisitedScene = session.averageTimeOnMostVisitedScene
        self.numberOfTouches = session.numberOfTouches
        self.averageTimeBetweenTouches = session.averageTimeBetweenTouches
        self.deviceType = session.deviceType
        self.iOSVersion = session.iOSVersion
        self.fontScale = session.fontScale

        super.init()
    }

    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }

    // MARK: - Serialization

    private enum CodingKeys: String, CodingKey {
        case sessionId
        case cuuSessionId
        case start
        case end
        case durationInSeconds
        case mostVisitedScene
        case averageTimeOnMostVisitedScene
        case numberOfTouches
        case averageTimeBetweenTouches
        case deviceType
        case iOSVersion
        case fontScale
    }

    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sessionId, forKey: .sessionId)
        try container.encode(cuuSessionId, forKey: .cuuSessionId)
        try container.encode(start, forKey: .start)
        try container.encode(end, forKey: .end)
        try container.encode(durationInSeconds, forKey: .durationInSeconds)
        try container.encodeIfPresent(mostVisitedScene, forKey: .mostVisitedScene)
        try container.encodeIfPresent(averageTimeOnMostVisitedScene, forKey: .averageTimeOnMostVisitedScene)
        try container.encode(numberOfTouches, forKey: .numberOfTouches)
        try container.encodeIfPresent(averageTimeBetweenTouches, forKey: .averageTimeBetweenTouches)
        try container.encodeIfPresent(deviceType, forKey: .deviceType)
        try container.encodeIfPresent(iOSVersion, forKey: .iOSVersion)
        try container.encodeIfPresent(fontScale, forKey: .fontScale)

        try super.encode(to: encoder)
    }
}
