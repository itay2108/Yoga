//
//  Plist.swift
//  Core
//
//  Created by Itay Gervash on 16/10/2025.
//

import Foundation

public enum Plist {

    public static func value<T>(fromInfoDictionaryKey key: PlistKey, bundle: Bundle = .main) -> T? {
        value(fromInfoDictionaryForStringKey: key.rawValue, bundle: bundle)
    }

    /// Return a value from the main Plist in the bundle
    /// - Parameter key: the key for which its value will be returned
    /// - Returns: the value for the specified key. Returns nil if key is not found
    public static func value<T>(fromInfoDictionaryForStringKey key: String, bundle: Bundle = .main) -> T? {
        // Get the main bundle's info dictionary
        guard let infoDictionary = bundle.infoDictionary else {
            print("Failed to retrieve main bundle's info dictionary.")
            return nil
        }

        // Use a recursive function to search for the key in nested dictionaries
        return recursiveValue(for: key, in: infoDictionary)
    }

    private static func recursiveValue<T>(for key: String, in dictionary: [String: Any]) -> T? {
        if let value = dictionary[key] {
            // Key found at the current level
            return value as? T
        }

        // Search in nested dictionaries
        for (_, nestedValue) in dictionary {
            if let nestedDictionary = nestedValue as? [String: Any] {
                if let result: T = recursiveValue(for: key, in: nestedDictionary) {
                    return result
                }
            }
        }

        // Key not found
        return nil
    }
}
