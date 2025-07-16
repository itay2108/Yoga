//
//  GetSessionsUseCase.swift
//  Domain
//
//  Created by Itay Gervash on 16/07/2025.
//

public protocol GetSessionsUseCase {
    func execute() -> Result<[Session], Error>
}

public struct DefaultGetSessionsUseCase: GetSessionsUseCase {

    let repository: any PlanRepository

    public init(repository: any PlanRepository) {
        self.repository = repository
    }

    public func execute() -> Result<[Session], Error> {
        repository.getSessions()
    }
}
