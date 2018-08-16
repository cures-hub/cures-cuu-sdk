//
//  PKTraitType.swift
//  CUU
//
//  Created by Florian Fittschen on 16.08.18.
//

import Foundation

enum PKTraitType: String, Codable {
    // positive adjectives
    case adventurous // e.g. looking at a lot of scenes for short time
    case fearless // e.g. pressing OK on alerts without reading them
    case observant
    case persistent
    case precise // e.g. taps in the center area of buttons/views
    case focused // e.g. high average time per scene

    // negative adjectives
    case hasty // e.g. very short sessions
    case stingy // e.g. not willing to give / pay
}
