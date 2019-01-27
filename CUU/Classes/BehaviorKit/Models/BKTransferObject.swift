//
//  BKTransferObject.swift
//  CUU
//
//  Created by Lara Marie Reimer on 18.08.18.
//

import Foundation

struct BKTransferObject: Encodable {
    
    var session: String
    var user: String
    var timestamp: Date
    
    var context: BKContextWrapper
    var description: String
    
    init(situation: BKSituation) {
        self.session = situation._session
        self.user = situation._user
        self.timestamp = situation.timestamp
        self.context = BKContextWrapper(situation.context)
        self.description = situation.description
    }
}

extension BKTransferObject {
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
        let urlString = baseUrl + "/v1/behaviorkit/projects/" + projectId + "/commits/" + commitHash + "/behavior"
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
