//
//  DefaultContactRepository.swift
//  Data
//
//  Created by Itay Gervash on 16/07/2025.
//

import Core
import Domain
import Foundation

public final class DefaultPlanRepository: PlanRepository {

    private let mockFileName: String = "sessions"

    public init() {}

    public func getSessions() -> Result<[Session], Error> {
        let decoder = JSONDecoder()

        do {
            if let response = decoder.readFromBundle(bundle: Bundle(for: DefaultPlanRepository.self), jsonFileName: mockFileName, type: SessionResponse.self) {
                let mappedSessions = try response.array.enumerated().map({
                    try $0.element.asSession(
                        withIndex: $0.offset
                    )
                })

                return .success(mappedSessions)
            } else {
                throw NSError.error(description: "Could not load session data")
            }
        } catch {
            return .failure(error)
        }
    }
}
