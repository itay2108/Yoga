//
//  AnyDecodable.swift
//  Core
//
//  Created by Itay Gervash on 16/10/2025.
//

import Foundation

public struct AnyDecodable: Decodable, @unchecked Sendable {
    let value: Any

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intVal = try? container.decode(Int.self) {
            value = intVal
        } else if let doubleVal = try? container.decode(Double.self) {
            value = doubleVal
        } else if let boolVal = try? container.decode(Bool.self) {
            value = boolVal
        } else if let stringVal = try? container.decode(String.self) {
            value = stringVal
        } else if let arrayVal = try? container.decode([AnyDecodable].self) {
            value = arrayVal.map(\.value)
        } else if let dictVal = try? container.decode([String: AnyDecodable].self) {
            value = dictVal.mapValues(\.value)
        } else {
            value = "Unsupported type"
        }
    }
}
