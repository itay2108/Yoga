//
//  PlanContainer.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

import Data
import Domain
import SwiftUI

final class PlanContainer {
    
    @MainActor
    func sessionsView() -> some View {
        let repository = DefaultPlanRepository()
        let useCase = DefaultGetSessionsUseCase(repository: repository)
        let viewModel = SessionsViewModel(useCase: useCase)
        return SessionsView(viewModel: viewModel)
    }
}
