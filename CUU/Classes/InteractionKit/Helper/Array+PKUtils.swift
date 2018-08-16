//
//  Array+PKUtils.swift
//  CUU
//
//  Created by Florian Fittschen on 12.08.18.
//

import Foundation

public extension Array where Element: Hashable {
    public var histogram: [Element: Int] {
        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
    }
}

public extension Collection where Element: BinaryFloatingPoint {
    public var average: Element {
        return self.reduce(0, +) / Element(0.distance(to: self.count))
    }
}

public extension Collection {
    public func count(where test: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(test).count
    }
}
