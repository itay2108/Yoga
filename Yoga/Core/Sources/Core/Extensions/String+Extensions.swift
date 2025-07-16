//
//  String+Extensions.swift
//  Domain
//
//  Created by Itay Gervash on 16/10/2025.
//

import Foundation

public extension String {

    var camelCaseToWords: String {
        do {
            let camelCaseRegex = try NSRegularExpression(pattern: "([a-z0-9])([A-Z])")
            return self.replacing(regex: camelCaseRegex, with: "$1 $2").capitalized
        } catch {
            debugPrint("Failed to convert camel case to words from \(self): \(error)")
            return self
        }
    }

    func replacing(regex: NSRegularExpression, with template: String) -> String {
        regex.stringByReplacingMatches(
            in: self,
            range: .init(location: 0, length: count),
            withTemplate: template
        )
    }

    mutating func transformToAscii() throws {
        let mutableUserAgent = (self as NSString).mutableCopy() as! CFMutableString

        if CFStringTransform(mutableUserAgent, nil, "Any-Latin; Latin-ASCII; [:^ASCII:] Remove" as CFString, false) {
            self = mutableUserAgent as String
        } else {
            throw NSError.error(description: "Could not transform string to ascii. Original string: \(self)")
        }
    }


    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom ..< endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom ..< substringTo])
            }
        }
    }

    var capitalizingFirstLetter: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst()
        return firstLetter + remainingLetters
    }

    var nilIfEmpty: String? {
        self.isEmpty ? nil : self
    }

    /// Returns `true` if any regular expression in the provided list matches the string.
    /// - Parameter regexList: An array of `NSRegularExpression` instances.
    /// - Returns: A Boolean value indicating whether at least one regex matches the string.
    func matchesAny(regexIn regexList: [NSRegularExpression]) -> Bool {
        let range = NSRange(location: 0, length: self.utf16.count)
        return regexList.contains { regex in
            regex.firstMatch(in: self, options: [], range: range) != nil
        }
    }

    init?<C: CustomStringConvertible>(_ value: C?) {
        guard let value else {
            return nil
        }

        self = String(describing: value)
    }
}
