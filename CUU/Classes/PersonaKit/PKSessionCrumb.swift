//
//  PKSessionCrumb.swift
//  CUU
//
//  Created by Florian Fittschen on 04.08.18.
//

import Foundation

struct PKSessionCrumb: Codable {

    /// The unique identifier of the current user.
    let userId: String

    /// The unique identifier of the session.
    let sessionId: String

    /// The cuu identifier of the session.
    let cuuSessionId: String

    /// The start of the session.
    let start: Date

    /// The end of the session.
    let end: Date?

    /// Custom characteristics that can be added as additional payload.
    var characteristics: PKSessionCharacteristics

    // MARK: - Lifecycle

    init(userId: String = CUUUserManager.sharedManager.userId, session: PKSession) {
        self.userId = userId
        self.sessionId = session.sessionId
        self.cuuSessionId = session.cuuSessionId
        self.start = session.start
        self.end = session.end
        self.characteristics = PKSessionCharacteristics(session: session)
    }
}

extension PKSessionCrumb {

    /// Send session to the CUU database.
    func send() {
        if let projectId = CUUConstants.projectId, let commitHash = CUUConstants.commitHash, let trackingToken = CUUConstants.trackingToken {
            sendToDatabase(projectId: projectId, commitHash: commitHash, trackingToken: trackingToken)
        }
    }

    /// Send session to the CUU database.
    ///
    /// - Parameters:
    ///   - projectId: The project ID of the app in the CUU system.
    ///   - commitHash: The commit hash under which the version of the app was saved.
    ///   - trackingToken: The token to authenticate with the CUU system for storing data remotely.
    private func sendToDatabase(projectId: String, commitHash: String, trackingToken: String) {
        // Construct the url.
        guard let baseUrl = CUUConstants.baseUrl else { return }
        let urlString = baseUrl + "/v1/personakit/projects/" + projectId + "/commits/" + commitHash + "/sessions"
        let url = URL(string: urlString)

        // Create the url request.
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(trackingToken, forHTTPHeaderField: "X-Tracking-Token")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Try to serialize session data.
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(self)
            urlRequest.httpBody = json
        } catch {
            print ("Error serializing session: \(error)")
            return
        }

        // Send the request.
        let task = URLSession.shared.dataTask(with: urlRequest)
        task.resume()
    }
}
