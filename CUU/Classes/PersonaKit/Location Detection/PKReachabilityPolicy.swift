//
//  PKReachabilityPolicy.swift
//  CUU
//
//  Created by Florian Fittschen on 15.08.18.
//

import Foundation

class PKReachabilityPolicy: PKLocationDetectionPolicy {
    let reachability: Reachability

    init?() {
        guard let reachability = Reachability() else { return nil }
        self.reachability = reachability
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
            return nil
        }
    }

    deinit {
        reachability.stopNotifier()
    }

    func calculateScore(for locationType: PKLocationType) -> Double {
        switch (locationType, reachability.connection) {
        case (.outdoor, .cellular):
            return 0.8
        case (.home, .wifi):
            return 0.7
        case (.office, .wifi), (.transit, .cellular):
            return 0.6
        case (.home, .cellular), (.office, .cellular), (.office, .none), (.transit, .wifi), (.transit, .none):
            return 0.2
        case (.home, .none), (.outdoor, .wifi), (.outdoor, .none):
            return 0.1
        }
    }
}
