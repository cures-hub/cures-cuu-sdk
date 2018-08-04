//
//  PKSession.swift
//  CUU
//
//  Created by Florian Fittschen on 01.08.18.
//

import Foundation

struct PKSession: Codable {

    /// The unique identifier of the session.
    let sessionId: String

    /// The start of the session.
    let start: Date

    /// The end of the session.
    let end: Date?

    init(sessionId: String = CUUSessionManager.sharedManager.currentSession, start: Date, end: Date? = nil) {
        self.sessionId = sessionId
        self.start = start
        self.end = end
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
}

extension PKSession: Identifiable {
    static let idKey = \PKSession.sessionId
}
