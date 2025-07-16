//
//  SessionsViewModel.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

import Core
import Combine
import Domain
import Foundation

@MainActor
final class SessionsViewModel: ObservableObject {
    typealias Model = [Session]

    private let useCase: GetSessionsUseCase

    @Published private(set) var loadingState: LoadingState<Model> = .idle

    @Published var isShowingInfoPopup: Bool = false
    @Published var currentSessionIndex: Int = defaults.integer(for: .latestCompletedSessionIndex) ?? 0

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - UI Properties

    let title: String = "my plan".uppercased()

    private var latestCompletedSessionIndex: Int {
        defaults.integer(for: .latestCompletedSessionIndex) ?? 0
    }

    private var currentSession: Session? {
        if case .loaded(let sessions) = loadingState {
            return sessions[safe: currentSessionIndex]
        } else {
            return nil
        }
    }

    var currentChapterTitle: String? {
        guard let currentSession else { return nil }

        return "chapter \(currentSession.chapter)".uppercased()
    }

    var currentChapterName: String? {
        guard let currentSession else { return nil }

        return currentSession.chapterName.capitalized
    }

    var backgroundImageName: String? {
        guard let chapter = currentSession?.chapter else { return nil }
        return "chapter\(chapter)_bg"
    }

    let infoPopupTitle: String = "Info"
    let infoPopupMessage: String = "This is a message"

    // MARK: - Lifecycle

    init(useCase: GetSessionsUseCase) {
        self.useCase = useCase
        setupSubscriptions()
    }

    func loadSessions() async {
        await useCase.execute()
            .whenSuccessful { sessions in
                Task { @MainActor in
                    self.loadingState = .loaded(sessions)
                }
            }
            .whenFailed { error in
                await DefaultLogger().log(error.localizedDescription, level: .error)

                Task { @MainActor in
                    self.loadingState = .failed(error)
                }
            }
    }

    // MARK: - Child ViewModels

    func cardViewModel(for session: Session) -> SessionCardViewModel {
        let viewModel = SessionCardViewModel(session: session)

        viewModel.sessionStartPressed
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isShowingInfoPopup = true
                self?.updateLatestCompletedSessionIfNeeded(toIndex: session.index)
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)

        return viewModel
    }

    func infoButtonPressed() {
        isShowingInfoPopup = true
    }
}

private extension SessionsViewModel {
    private func updateLatestCompletedSessionIfNeeded(toIndex newLatestCompletedSessionIndex: Int) {
        if newLatestCompletedSessionIndex > latestCompletedSessionIndex {
            defaults.set(newLatestCompletedSessionIndex, for: .latestCompletedSessionIndex)
        } else {
            return
        }
    }

    private func setupSubscriptions() {
        $currentSessionIndex
            .dropFirst()
            .delay(for: 0.3, scheduler: DispatchQueue.main)
            .sink { _ in
                Haptics.softImpact()
            }
            .store(in: &cancellables)
    }
}
