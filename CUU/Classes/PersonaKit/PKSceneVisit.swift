//
//  PKSceneVisit.swift
//  CUU
//
//  Created by Florian Fittschen on 13.08.18.
//

import Foundation

enum PKSceneVisit {
    case didAppear(name: String, timestamp: Date)
    case didDisappear(name: String, timestamp: Date)
}

extension PKSceneVisit {
    var name: String {
        switch self {
        case .didAppear(let name, _), .didDisappear(let name, _):
            return name
        }
    }

    var timestamp: Date {
        switch self {
        case .didAppear(_, let timestamp), .didDisappear(_, let timestamp):
            return timestamp
        }
    }

    var isDidAppear: Bool {
        switch self {
        case .didAppear:
            return true
        default:
            return false
        }
    }

    var isDidDisappear: Bool {
        switch self {
        case .didDisappear:
            return true
        default:
            return false
        }
    }
}
