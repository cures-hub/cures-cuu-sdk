//
//  FKCrumb.swift
//  CUU
//
//  Created by Lara Marie Reimer on 10.12.17.
//

import Foundation

public protocol CUUCrumb : Codable {
    var name: String { get }
    var type: String { get }
    var timestamp: Date { get }
    var sessionId: String { get }
    var userId: String { get }
}

extension CUUCrumb {
    func send(projectId: String, commitHash: String, trackingToken: String) {
        guard let baseUrl = CUUUtils.baseUrl else { return }
        let urlString = baseUrl + "/v1/projects/" + projectId + "/commits/" + commitHash + "/crumbs"
        let url = URL(string: urlString)
        
        print(urlString)
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(trackingToken, forHTTPHeaderField: "X-Tracking-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(self)
            urlRequest.httpBody = json
        } catch _ {
            print ("Error serializing crumb of type " + self.type)
            return
        }
    
        let task = URLSession.shared.dataTask(with: urlRequest)
        task.resume()
        
        print("Crumb sent.")
    }
}
