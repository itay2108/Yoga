//
//  Loading State.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import Foundation
import Combine

typealias LoadingStateSubject<T> = CurrentValueSubject<LoadingState<T>, Never>

public enum LoadingState<T>: Equatable {
    case idle
    case loading
    case failed(Error)
    case loaded(T)

    public static func == (lhs: LoadingState<T>, rhs: LoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading):
            return true
        case (.failed(let lError), .failed(let rError)):
            return (lError as NSError).domain == (rError as NSError).domain &&
                   (lError as NSError).code == (rError as NSError).code
        case (.loaded, .loaded):
            return false
        default:
            return false
        }
    }
}

public extension LoadingState {
    init?(_ value: T) {
        self = .loaded(value)
    }
}
