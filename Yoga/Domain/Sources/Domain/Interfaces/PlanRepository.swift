//
//  PlanRepository.swift
//  Domain
//
//  Created by Itay Gervash on 16/07/2025.
//

public protocol PlanRepository {
    func getSessions() -> Result<[Session], Error>
}
