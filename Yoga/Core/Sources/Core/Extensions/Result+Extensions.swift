//
//  Result+Additions.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation

public extension Result {

    /// Returns a new Result object given the original is successful, using the passed block.
    /// - Parameter transform: the block that will return the new Result object based on the success value
    /// - Returns: a generic result object
    func transform<T>(_ transform: @Sendable (Success) async throws -> Result<T, Error>) async -> Result<T, Error> {
        switch self {
        case .success(let success):
            do {
                let newSuccess = try await transform(success)
                return newSuccess
            } catch {
                return .failure(error)
            }
        case .failure(let failure):
            return .failure(failure)
        }
    }

    func fallBack(with fallbackMethod: @Sendable (Failure) async -> Self) async -> Self {
        switch self {
        case .success(let success):
            return .success(success)
        case .failure(let error):
            return await fallbackMethod(error)
        }
    }

    @discardableResult
    func whenSuccessful(perform onSuccess: @Sendable (Success) async -> Void) async -> Result<Success, Failure> {
        switch self {
        case .success(let value):
            await onSuccess(value)
            return .success(value)
        case .failure(let error):
            return .failure(error)
        }
    }


    @discardableResult
    func whenFailed(perform onFailure: @Sendable (Failure) async -> Void) async -> Result<Success, Failure> {
        switch self {
        case .success(let value):
            return .success(value)
        case .failure(let error):
            await onFailure(error)
            return .failure(error)
        }
    }

    @discardableResult
    func throwErrors() throws -> Success {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
