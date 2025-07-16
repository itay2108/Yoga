//
//  NSError+Extensions.swift
//  Core
//
//  Created by Itay Gervash on 16/10/2025.
//

import Foundation

public extension NSError {
    static func error(domain: String = Bundle.main.bundleIdentifier ?? "", code: Int? = nil, description: String) -> NSError {
        NSError(
            domain: domain,
            code: code ?? description.hashValue % 0xFFF,
            userInfo: [NSLocalizedDescriptionKey: description]
        )
    }
}
