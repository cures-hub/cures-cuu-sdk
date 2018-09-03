//
//  BKDefaultInterceptorConfiguration.swift
//  CUU
//
//  Created by Lara Marie Reimer on 05.08.18.
//

import Foundation

public class BKDefaultPredictorConfiguration {
    @available(iOS 11.0, *)
    public static func provideDefaultPredictor() -> BKPredictor {
        let contextFactories: [BKContextFactory] = [
            BKAgeGroupFactory(),
            BKGenderFactory(),
            BKSmartphoneExperienceFactory(),
            BKOrientationFactory(),
            BKProductivenessFactory(),
            BKUXInconsistencyFactory(),
            BKMissingInteractionElementFactory()
        ]
        
        return BKSituationPredictor(delegate: BehaviorKit.shared, contextFactories: contextFactories)
        
    }
}

