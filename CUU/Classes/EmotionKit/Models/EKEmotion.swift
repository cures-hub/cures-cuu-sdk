//
//  Emotion.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 23.12.17.
//

import Foundation

protocol EKEmotion: Encodable {

    static var type: EKEmotionType { get }

    init(given actionUnits: [EKActionUnit])

    var probability: Float { get }

    var emoji: String { get }

}

extension EKEmotion {
    static func getProbability(of actionUnit: EKActionUnit?) -> Float {
        return actionUnit?.probability ?? 0
    }
}

extension Sequence where Iterator.Element == EKEmotion
{
    func mostLikely() -> EKEmotion? {
        return self.max { a, b in a.probability < b.probability }
    }
}

extension Sequence where Iterator.Element == EKEmotion.Type
{
    func given(_ actionUnits: [EKActionUnit]) -> [EKEmotion] {
        return map {
            return $0.init(given: actionUnits)
        }
    }
}
