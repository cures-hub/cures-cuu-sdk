//
//  PKLocationType.swift
//  CUU
//
//  Created by Florian Fittschen on 13.08.18.
//

import Foundation

enum PKLocationType: String {
    case home
    case office
    case transit
    case outdoor
}

extension PKLocationType {
    static var allCases: [PKLocationType] = [
        .home, .office, .transit, .outdoor
    ]
 }
