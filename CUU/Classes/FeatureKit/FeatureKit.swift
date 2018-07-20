//
//  FeatureKit.swift
//  CUU
//
//  Created by Lara Marie Reimer on 10.12.17.
//

import Foundation

/**
 *  Open class to exhibit FeatureKit behavior.
 **/
open class FeatureKit {
    
    static var isActive = false
    
    /*
    *   Starts featureKit.
    */
    static func start() {
        FeatureKit.isActive = true
    }
    
    /*
     *   Stops featureKit.
     */
    static func stop() {
        FeatureKit.isActive = false
    }

    
    /**
    *   Open method to handle crumb saving.
    *   @param name: the name of the crumb to be created and stored
    **/
    public static func seed(name: String) {
        if FeatureKit.isActive {
            let actionCrumb = FKActionCrumb(name: name)
            actionCrumb.send()
        }
    }
}
