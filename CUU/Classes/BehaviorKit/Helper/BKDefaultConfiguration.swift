//
//  BKDefaultConfiguration.swift
//  CUU
//
//  Created by Lara Marie Reimer on 05.08.18.
//

import Foundation

public struct BKDefaultConfiguration: BKConfiguration {

    public let storage: BKStorage
    public let frequency: TimeInterval
    public let predictor: BKPredictor?
    
    init(forUser user: String) {
        self.storage = BKCoreDataStorage()
        if #available(iOS 11.0, *) {
            self.predictor = BKDefaultPredictorConfiguration.provideDefaultPredictor()
        } else {
            self.predictor = nil
        }
        self.frequency = 10.0
    }
}
