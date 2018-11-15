//
//  CUUNetworkObject.swift
//  CUU
//
//  Created by Lara Marie Reimer on 16.10.18.
//

import Foundation

struct CUUNetworkObject: Encodable {
    let type: String
    let payload: String
}

extension Array where Element == CUUNetworkObject {
    /**
     *   Public method to be called to send crumbs to the CUU database.
     **/
    func send(with completion: @escaping (_ succeeded: Bool) -> Void) {
        if let projectId = CUUConstants.projectId, let commitHash = CUUConstants.commitHash, let trackingToken = CUUConstants.trackingToken {
            sendToDatabase(projectId: projectId, commitHash: commitHash, trackingToken: trackingToken, with: { succeeded in
                completion(succeeded)
            })
        }
    }
    
    /**
     *   Private method for handling crumb sending.
     *   @param projectId: the project ID of the app in the CUU system.
     *   @param commitHash: The commit hash under which the version of the app was saved.
     *   @param trackingToken: The token to authenticate with the CUU system for storing data remotely.
     **/
    private func sendToDatabase(projectId: String, commitHash: String, trackingToken: String, with completion: @escaping (_ succeeded: Bool) -> Void) {
        // Construct the url.
        guard let baseUrl = CUUConstants.baseUrl else { return }
        let urlString = baseUrl + "/v1/projects/" + projectId + "/commits/" + commitHash + "/batch"
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
            print ("Error serializing array of CUUNetworkObject")
            return
        }
        
        // Send the request.
        let task = URLSession.shared.dataTask(with: urlRequest, completionHandler: {data, response, error in
            completion((error == nil) && (response != nil))
        })
        task.resume()
    }
}
