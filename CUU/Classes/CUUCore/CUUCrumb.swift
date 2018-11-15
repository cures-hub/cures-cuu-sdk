//
//  FKCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 10.12.17.
//

import Foundation

/**
 *  Protocol for CUUCrumbs.
 **/
public protocol CUUCrumb : Codable {

    /**
    *   The id of the crumb.
    **/
    var id: String { get }

    /**
    *   The name of the crumb.
    **/
    var name: String { get }
    
    /**
    *   The type of the crumb. E.g. action, interaction, ...
    **/
    var type: String { get }
    
    /**
    *   The timestamp when the crumb is created.
    **/
    var timestamp: Date { get }
    
    /**
    *   The current session ID.
    **/
    var sessionId: String { get }
    
    /**
    *   The current user ID.
    **/
    var userId: String { get }
    
    /**
    *   Custom parameters that can be added to the crumb.
    **/
    var characteristics: CUUCharacteristics? { get }
}

extension CUUCrumb {
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
        let urlString = baseUrl + "/v1/projects/" + projectId + "/commits/" + commitHash + "/crumbs"
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
            print ("Error serializing crumb of type " + self.type)
            return
        }
        
        // Send the request.
        let task = URLSession.shared.dataTask(with: urlRequest)
        task.resume()
    }
}
