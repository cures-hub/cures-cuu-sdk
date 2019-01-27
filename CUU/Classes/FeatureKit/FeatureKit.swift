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

class FeatureKit {
    static var isActive = false
    
    static var activatedFeatures: [CUUFeature]? = []
    
    /*
     *   Starts featureKit.
     */
    static func start() {
        FeatureKit.isActive = true
        
        // Get all activated features for this commit version.
        FeatureKit.activatedFeaturesForCurrentCommit()
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
    
    // MARK: Networking
    
    /*
     *   Method for retrieving activated features for the database.
     */
    static func activatedFeaturesForCurrentCommit() {
        if let projectId = CUUConstants.projectId, let commitHash = CUUConstants.commitHash, let trackingToken = CUUConstants.trackingToken, let baseUrl = CUUConstants.baseUrl {
            // Construct the url.
            let urlString = baseUrl + "/v1/projects/" + projectId + "/commits/" + commitHash + "/activatedFeatures"
            let url = URL(string: urlString)
            
            // Create the url request.
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "GET"
            urlRequest.setValue(trackingToken, forHTTPHeaderField: "X-Tracking-Token")
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            // Send the request.
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    // Try to serialize crumb data.
                    do {
                        let decoder = JSONDecoder()
                        let features = try decoder.decode([CUUFeature].self, from: data)
                        FeatureKit.activatedFeatures = features
                    } catch {
                        print(error)
                    }
                } else {
                    print(error as Any)
                }
            }
            task.resume()
        }
    }
    
    // MARK: Helper Methods
    
    /*
     *   Checks if any action needs to be performed for the triggered crumb.
     *   @parameter crumb: the crumb fo which this action should be performed.
     */
    func handleAdditionalCrumbActionsForFeatures(with crumb: FKActionCrumb) {
        // Dispatch a notification that a new feature crumb was triggered.
        let correspondingActivatedFeature = feature(for: crumb)
        let payload = ["crumbId": crumb.id,
                        "isFirst": isFirst(crumb: crumb, in: correspondingActivatedFeature),
                        "isLast": isLast(crumb: crumb, in: correspondingActivatedFeature),
                        "feature": correspondingActivatedFeature as Any
            ] as [String : Any]
        NotificationCenter.default.post(name: .didTriggerCrumb, object: nil, userInfo: payload)
    }
    
    func feature(for crumb: FKActionCrumb) -> CUUFeature? {
        if let activatedFeatures = FeatureKit.activatedFeatures {
            for feature in activatedFeatures {
                for featureCrumb in feature.steps {
                    if featureCrumb == crumb.name {
                        return feature
                    }
                }
            }
        }
        return nil
    }
    
    func isFirst(crumb: FKActionCrumb, in feature: CUUFeature?) -> Bool {
        if let feature = feature {
            if feature.steps.count > 0 && feature.steps.first == crumb.name {
                return true
            }
        }
        return false
    }
    
    func isLast(crumb: FKActionCrumb, in feature: CUUFeature?) -> Bool {
        if let feature = feature {
            if feature.steps.count > 0 && feature.steps.last == crumb.name {
                return true
            }
        }
        return false
    }
}
