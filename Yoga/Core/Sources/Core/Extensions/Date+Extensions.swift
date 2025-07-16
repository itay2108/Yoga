//
//  Date+Additions.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation

public extension Date {

    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }

    var nextStartOfDay: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: self)) ?? self
    }

    var endOfDay: Date {
        Calendar.current.date(byAdding: .second, value: -1, to: nextStartOfDay) ?? self
    }

    func adding(component: Calendar.Component, amount: Int) -> Date? {
        return Calendar.current.date(byAdding: component, value: amount, to: self)
    }

    func addComponents(from date: Date?, components: [Calendar.Component]) -> Date? {
        guard let date else { return nil }

        let sourceComponents = Calendar.current.dateComponents(Set(components), from: date)
        var targetComponents = Calendar.current.dateComponents(in: TimeZone.current, from: self)

        for component in components {
            if let value = sourceComponents.value(for: component) {
                targetComponents.setValue(value, for: component)
            }
        }

        return Calendar.current.date(from: targetComponents)
    }
}
