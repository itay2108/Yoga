//
//  Double+Extensions.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation

public extension NumberFormatter {
    func double(from string: String) -> Double? {
        guard let number = number(from: string) else { return nil }
        return Double(truncating: number)
    }
}
