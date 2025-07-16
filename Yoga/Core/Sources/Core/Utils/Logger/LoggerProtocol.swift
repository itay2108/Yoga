//
//  LoggerProtocol.swift
//  Core
//
//  Created by Itay Gervash on 16/10/2025.
//

import Foundation

public protocol LoggerProtocol: Sendable {
    func log(_ message: @Sendable @autoclosure () -> String, level: LogLevel) async
}
