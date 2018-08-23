//
//  RingBuffer.swift
//  CUU
//
//  Created by Florian Fittschen on 14.08.18.
//
//  Modified version of https://github.com/raywenderlich/swift-algorithm-club/tree/master/Ring%20Buffer

public struct RingBuffer<T> {
    private var array: [T?]
    private var writeIndex = 0

    public init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }

    public mutating func write(_ element: T) {
        defer {
            writeIndex += 1
        }
        array[wrapped: writeIndex] = element
    }

    /* Returns nil if the buffer is empty. */
    public mutating func readItem(numberOfItemsBeforeWriteIndex number: Int) -> T? {
        guard !isEmpty else { return nil }
        return array[wrapped: writeIndex - number]
    }

    public var isEmpty: Bool {
        return array.compactMap({ $0 }).isEmpty
    }
}

private extension Array {
    subscript (wrapped index: Int) -> Element {
        get {
            let calculatedIndex = mod(index, count)
            assert(calculatedIndex >= 0 && calculatedIndex < self.count, "Index out of bounds")
            return self[calculatedIndex]
        }
        set {
            let calculatedIndex = mod(index, count)
            assert(calculatedIndex >= 0 && calculatedIndex < self.count, "Index out of bounds")
            self[calculatedIndex] = newValue
        }
    }
}

private func mod(_ a: Int, _ n: Int) -> Int {
    precondition(n > 0, "modulus must be positive")
    let r = a % n
    return r >= 0 ? r : r + n
}

