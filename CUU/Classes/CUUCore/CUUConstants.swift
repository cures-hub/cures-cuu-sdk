//
//  CUUConstants.swift
//  CUU
//
//  Created by Lara Marie Reimer on 16.01.18.
//

import Foundation

/**
*   Class for storing constants that are used in the CUU framework.
**/
struct CUUConstants {
    /**
    *   UserDefaults keys.
    **/
    struct CUUUserDefaultsKeys {
        static let userIdKey = "de.tum.in.ase.cuu.featurekit.userid"
        static let optionsKey = "de.tum.in.ase.cuu.options"
        static let lastFetchDateKey = "de.tum.in.ase.cuu.lastFetchDate"
        static let thinkingAloudFeaturesKey = "de.tum.in.ase.cuu.thinkingaloudkit.features"
    }
    
    /**
    *   The possible crumb types.
    **/
    struct CrumbTypes {
        static let actionCrumb = "action"
        static let interactionCrumb = "interaction"
        static let behaviorCrumb = "behavior"
    }
    
    static let projectId: String? = {
        if let plist = CUUPlistDictionary {if let projectId = plist.object(forKey: "CUUProjectID") as? String {
            return projectId
        } else {
            return nil
            }
        } else {
            return nil
        }
    }()
    
    static let commitHash: String? = {
        if let plist = CUUPlistDictionary {
            if let commitHash = plist.object(forKey: "CUUCommitHash") as? String {
                return commitHash
            } else {
                return nil
            }
        } else {
            return nil
        }
    }()
    
    static let trackingToken: String? = {
        if let plist = CUUPlistDictionary {
            if let trackingToken = plist.object(forKey: "CUUTrackingToken") as? String {
                return trackingToken
            } else {
                return nil
            }
        } else {
            return nil
        }
    }()
    
    static let baseUrl: String? = {
        if let plist = CUUPlistDictionary {
            if let url = plist.object(forKey: "CUUApiEndpoint") as? String {
                return url
            } else {
                return nil
            }
        } else {
            return nil
        }
    }()
    
    static var CUUPlistDictionary: NSDictionary? {
        get {
            if let path = Bundle.main.path(forResource: "CUU", ofType: "plist") {
                return NSDictionary(contentsOfFile: path)
            } else {
                return nil
            }
        }
    }
}
