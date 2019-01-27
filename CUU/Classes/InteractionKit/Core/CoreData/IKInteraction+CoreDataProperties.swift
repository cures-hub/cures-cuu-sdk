//
//  IKInteraction+CoreDataProperties.swift
//
//
//  Created by Lara Marie Reimer on 27.07.18.
//
//

import Foundation
import CoreData


extension IKInteraction {
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<IKInteraction> {
        return NSFetchRequest<IKInteraction>(entityName: "IKInteraction")
    }
    
    @NSManaged public var userId: String
    @NSManaged public var timestamp: Date
    @NSManaged public var sessionId: String
    @NSManaged public var name: String
    @NSManaged public var characteristics: String
    
}

extension IKInteraction {
    /**
     *   Public method to be called to send crumbs to the CUU database.
     **/
    func send() {
        if let projectId = CUUConstants.projectId, let commitHash = CUUConstants.commitHash, let trackingToken = CUUConstants.trackingToken {
            sendToDatabase(projectId: projectId, commitHash: commitHash, trackingToken: trackingToken)
        }
    }
    
    /**
     *   Private method for handling crumb sending.
     *   @param projectId: the project ID of the app in the CUU system.
     *   @param commitHash: The commit hash under which the version of the app was saved.
     *   @param trackingToken: The token to authenticate with the CUU system for storing data remotely.
     **/
    private func sendToDatabase(projectId: String, commitHash: String, trackingToken: String) {
        // Construct the url.
        guard let baseUrl = CUUConstants.baseUrl else { return }
        let urlString = baseUrl + "/v1/interactionkit/projects/" + projectId + "/commits/" + commitHash + "/interactions"
        let url = URL(string: urlString)
        
        // Create the url request.
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(trackingToken, forHTTPHeaderField: "X-Tracking-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Try to serialize crumb data.
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(self)
            urlRequest.httpBody = json
        } catch _ {
            print ("Error serializing interaction")
            return
        }
        
        // Send the request.
        let task = URLSession.shared.dataTask(with: urlRequest)
        task.resume()
    }
}

