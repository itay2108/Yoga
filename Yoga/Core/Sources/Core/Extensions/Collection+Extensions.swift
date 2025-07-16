//
//  Collection+Additions.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

