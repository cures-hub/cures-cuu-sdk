//
//  FKUtils.swift
//  CUU
//
//  Created by Lara Marie Reimer on 14.01.18.
//

import Foundation

class CUUUtils {
    static let projectId: String? = {
        if let plist = CUUConstants.infoPlistDictionary {if let projectId = plist.object(forKey: "CUUProjectID") as? String {
                return projectId
            } else {
                return nil
            }
        } else {
            return nil
        }
    }()
    
    static let commitHash: String? = {
        if let plist = CUUConstants.infoPlistDictionary {
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
        if let plist = CUUConstants.infoPlistDictionary {
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
        if let plist = CUUConstants.infoPlistDictionary {
            if let url = plist.object(forKey: "CUUApiEndpoint") as? String {
                return url
            } else {
                return nil
            }
        } else {
            return nil
        }
    }()
    
    struct CUUConstants {
        static var infoPlistDictionary: NSDictionary? {
            get {
                if let path = Bundle.main.path(forResource: "CUU", ofType: "plist") {
                    return NSDictionary(contentsOfFile: path)
                } else {
                    return nil
                }
            }
        }
    }
}
