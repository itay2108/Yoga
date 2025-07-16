//
//  Comparable+Extensions.swift
//
//
//  Created by Itay Gervash on 24/06/2024.
//

import Foundation

public extension Comparable {

    /// Returns the comparable value limited in the specified range
    /// - Parameters:
    ///   - lowerLimit: the bottom limit for which the value cannot be lower of
    ///   - upperLimit: the upper limit for which the value cannot be higher of
    /// - Returns: the lower limit if the value is lower than it, the upper limit if the value is higher that it, or the original value if it is in the valid range.
    ///
    /// ```
    /// 100.limited(from: 0, to: 1000) // returns 100
    /// 100.limited(from: 200, to: 300) // returns 200
    /// 100.limited(from: 0, to: 10) // returns 10
    /// ```
    func clamped(from lowerLimit: Self? = nil, to upperLimit: Self? = nil) -> Self {

        if let lowerLimit, self < lowerLimit {
            return lowerLimit
        } else if let upperLimit, self > upperLimit {
            return upperLimit
        } else {
            return self
        }
    }
}
