//
//  Action Units.swift
//  EmotionsKit
//
//  Created by Jan Philip Bernius on 18.12.17.
//

import Foundation

protocol EKActionUnit {

    init(from face: EKFace)

    var probability: Float { get }

}

extension Sequence where Iterator.Element == EKActionUnit
{
    func inferByType<T: EKActionUnit>() -> T? {
        return filter({ $0 is T}).first as? T
    }
}

extension Sequence where Iterator.Element == EKActionUnit.Type
{
    func from(_ face: EKFace) -> [EKActionUnit] {
        return map {
            return $0.init(from: face)
        }
    }
}
