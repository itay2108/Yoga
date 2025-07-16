//
//  Utils.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation

public enum Utils {
    public static var isRunningTests: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
}
