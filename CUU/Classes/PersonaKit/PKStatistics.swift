//
//  PKStatistics.swift
//  CUU
//
//  Created by Florian Fittschen on 13.08.18.
//

import UIKit

struct PKStatistics {

    var totalUsageDuration: TimeInterval = 0

    private let identifier: UUID

    init?() {
        guard let identifier = UIDevice.current.identifierForVendor else { return nil }
        self.identifier = identifier
    }
}

extension PKStatistics: Codable { }

extension PKStatistics: Identifiable {
    typealias ID = String
    static let idKey = \PKStatistics.identifier.uuidString
}
