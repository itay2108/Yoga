//
//  DateFormatter+Extensions.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//


import Foundation

public extension DateFormatter {
    convenience init(
        dateFormat: String,
        timeZoneIdentifier: String? = nil
    ) {
        self.init()
        self.dateFormat = dateFormat
        
        if let timeZoneIdentifier {
            timeZone = TimeZone(identifier: timeZoneIdentifier)
        }
    }
}
