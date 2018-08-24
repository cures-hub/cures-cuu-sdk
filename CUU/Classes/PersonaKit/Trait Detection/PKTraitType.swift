//
//  PKTraitType.swift
//  CUU
//
//  Created by Florian Fittschen on 16.08.18.
//

import Foundation

enum PKTraitType: String, Codable {
    // positive adjectives
    case adventurous // e.g. looking at a lot of scenes within a time period
    case fearless // e.g. pressing OK on alerts without reading them
    case observant
    case persistent
    case precise // e.g. taps in the center area of buttons/views
    case focused // e.g. high average time per scene
    case theFlash // e.g. averageTimeBetweenTouches < 1 seconds

    // negative adjectives
    case hasty // e.g. very short sessions
    case confused // e.g. looking at some scenes for short durations, i.e. going back immediately
    case stingy // e.g. not willing to give / pay
}
