//
//  AnyEmotion.swift
//  CUU
//
//  Created by Jan Philip Bernius on 11.07.18.
//

import Foundation

struct EKAnyEmotion: Encodable {
    var emotion: EKEmotion

    init(_ emotion: EKEmotion) {
        self.emotion = emotion
    }

    private enum CodingKeys : CodingKey {
        case type, emotion
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type(of: emotion).type, forKey: .type)
        try emotion.encode(to: encoder)
    }
}

enum EKEmotionType : String, Codable {

    // be careful not to rename these – the encoding/decoding relies on the string
    // values of the cases. If you want the decoding to be reliant on case
    // position rather than name, then you can change to enum TagType : Int.
    // (the advantage of the String rawValue is that the JSON is more readable)
    case anger, contempt, disgust, fear, happiness, sadness, surprise

    var metatype: EKEmotion.Type {
        switch self {
        case .anger:
            return EKAnger.self
        case .contempt:
            return EKContempt.self
        case .disgust:
            return EKDisgust.self
        case .fear:
            return EKFear.self
        case .happiness:
            return EKHappiness.self
        case .sadness:
            return EKSadness.self
        case .surprise:
            return EKSurprise.self
        }
    }
}
