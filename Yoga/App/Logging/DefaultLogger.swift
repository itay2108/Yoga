//
//  DefaultLogger.swift
//  Yoga
//
//  Created by Itay Gervash on 16/10/2025.
//

import Core

struct DefaultLogger: LoggerProtocol {
    func log(_ message: @autoclosure () -> String, level: LogLevel) async {
        print(message())
    }
}

