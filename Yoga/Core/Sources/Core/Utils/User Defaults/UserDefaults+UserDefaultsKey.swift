//
//  UserDefaults+UserDefaultsKey.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation

public extension UserDefaults {

    func string(for key: UserDefaultsKey) -> String? {
        return key.value(forType: String.self)
    }

    func bool(for key: UserDefaultsKey) -> Bool? {
        return key.value(forType: Bool.self)
    }

    func integer(for key: UserDefaultsKey) -> Int? {
        return key.value(forType: Int.self)
    }

    func float(for key: UserDefaultsKey) -> Float? {
        return key.value(forType: Float.self)
    }

    func double(for key: UserDefaultsKey) -> Double? {
        return key.value(forType: Double.self)
    }

    func number(for key: UserDefaultsKey) -> NSNumber? {
        return key.value(forType: NSNumber.self)
    }

    func date(for key: UserDefaultsKey) -> Date? {
        return key.value(forType: Date.self)
    }

    func array(for key: UserDefaultsKey) -> [Any]? {
        return key.value(forType: NSArray.self) as? [Any]
    }

    func dictionary(for key: UserDefaultsKey) -> [String: Any]? {
        return key.value(forType: NSDictionary.self) as? [String: Any]
    }

    func dictionaryArray(for key: UserDefaultsKey) -> [[String: Any]]? {
        return key.value(forType: NSArray.self) as? [[String: Any]]
    }

    func data(for key: UserDefaultsKey) -> Data? {
        return key.value(forType: Data.self)
    }


    func set<T>(_ value: T?, for key: UserDefaultsKey) {
        if let value = value {
            set(value, forKey: key.rawValue)
        } else {
            removeValue(for: key)
        }
    }

    func removeValue(for key: UserDefaultsKey) {
        removeObject(forKey: key.rawValue)
    }
}
