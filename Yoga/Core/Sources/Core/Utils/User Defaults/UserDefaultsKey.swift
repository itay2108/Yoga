//
//  UserDefaultsKey.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation

nonisolated(unsafe) public let defaults = UserDefaults.standard

public enum UserDefaultsKey: String, CaseIterable {

    case latestCompletedSessionIndex

    func value<T>(forType type: T.Type) -> T? {
        let object = defaults.object(forKey: self.rawValue)
        return object as? T
    }
}
