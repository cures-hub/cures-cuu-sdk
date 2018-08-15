//
//  PKDateTimePolicy.swift
//  CUU
//
//  Created by Florian Fittschen on 15.08.18.
//

import Foundation

class PKDateTimePolicy: PKLocationDetectionPolicy {
    fileprivate enum DateTime {
        case weekdayWorkhours
        case weekdayAfterhours
        case weekend
    }

    func calculateScore(for locationType: PKLocationType) -> Double {
        let dateTime = DateTime(from: Date())
        switch (locationType, dateTime)  {
        case (.office, .weekdayWorkhours):
            return 0.7
        case (.home, .weekdayAfterhours), (.outdoor, .weekend):
            return 0.5
        case (.transit, .weekdayAfterhours), (.outdoor, .weekdayAfterhours), (.home, .weekend), (.transit, .weekend):
            return 0.4
        case (.transit, .weekdayWorkhours), (.office, .weekdayAfterhours):
            return 0.2
        case (.home, .weekdayWorkhours), (.outdoor, .weekdayWorkhours), (.office, .weekend):
            return 0.1
        }
    }
}

extension PKDateTimePolicy.DateTime {
    init(from date: Date) {
        if date.isWeekend {
            self = .weekend
        } else if date.isDuringWorkingHours {
            self = .weekdayWorkhours
        } else {
            self = .weekdayAfterhours
        }
    }
}

private extension Date {
    var isWeekday: Bool {
        return !Calendar.current.isDateInWeekend(self)
    }
    var isWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }

    var isDuringWorkingHours: Bool {
        guard let workingHoursStart = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: self),
            let workingHoursEnd = Calendar.current.date(bySettingHour: 17, minute: 0, second: 0, of: self) else {
                preconditionFailure("Cannot create dates for working hours.")
        }

        return (workingHoursStart...workingHoursEnd).contains(self)
    }
}
