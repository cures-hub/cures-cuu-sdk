//
//  EKEmotionDictionary+Upload.swift
//  CUU
//
//  Created by Jan Philip Bernius on 11.07.18.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}

// Dictionary<Key, [EKEmotion]>
extension Dictionary where Key == Date, Value == [EKEmotion] {
    func upload(for crumbId: String) {
        prepare().upload(for: crumbId)
    }

    private func prepare() -> Dictionary<String, [EKAnyEmotion]> {
        var uploadDictionary = Dictionary<String, [EKAnyEmotion]>()
        forEach { (date, emotions) in
            uploadDictionary.updateValue(emotions.map(EKAnyEmotion.init), forKey: "\(date.millisecondsSince1970)")
        }
        return uploadDictionary
    }
}

// Dictionary<Key, [EKAnyEmotion]>
extension Dictionary where Key == String, Value == [EKAnyEmotion] {
    fileprivate func upload(for crumbId: String) {
        guard let baseUrl = CUUConstants.baseUrl,
            let projectId = CUUConstants.projectId,
            let trackingToken = CUUConstants.trackingToken,
            let url = URL(string: baseUrl + "/v1/emotionkit/projects/\(projectId)/crumbs/\(crumbId)/emotions")
            else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue(trackingToken, forHTTPHeaderField: "X-Tracking-Token")
        urlRequest.setValue(crumbId, forHTTPHeaderField: "X-Crumb-ID")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let encoder = JSONEncoder()
            let json = try encoder.encode(self)
            urlRequest.httpBody = json
        } catch _ {
            print ("Error serializing emotions")
            return
        }

        let task = URLSession.shared.dataTask(with: urlRequest)
        task.resume()
    }
}
