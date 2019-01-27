//
//  BKAnyContext.swift
//  CUU
//
//  Created by Lara Marie Reimer on 12.08.18.
//

import Foundation

struct BKContextWrapper: Encodable {
    var missingInteractionElementContext: BKMissingInteractionElementContext
    var ageGroupContext: BKAgeGroupContext
    var productivenessContext: BKProductivenessContext
    var orientationContext: BKOrientationContext
    var smartphoneExperienceContext: BKSmartphoneExperienceContext
    var uxInconsistencyContext: BKUXInconsistencyContext
    var genderContext: BKGenderContext
    
    init(_ contexts: [String : BKContext]) {
        self.missingInteractionElementContext = contexts[String(describing: BKMissingInteractionElementContext.self)] as! BKMissingInteractionElementContext
        self.ageGroupContext = contexts[String(describing: BKAgeGroupContext.self)] as! BKAgeGroupContext
        self.productivenessContext = contexts[String(describing: BKProductivenessContext.self)] as! BKProductivenessContext
        self.orientationContext = contexts[String(describing: BKOrientationContext.self)] as! BKOrientationContext
        self.smartphoneExperienceContext = contexts[String(describing: BKSmartphoneExperienceContext.self)] as! BKSmartphoneExperienceContext
        self.uxInconsistencyContext = contexts[String(describing: BKUXInconsistencyContext.self)] as! BKUXInconsistencyContext
        self.genderContext = contexts[String(describing: BKGenderContext.self)] as! BKGenderContext
    }
}
