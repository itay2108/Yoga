//
//  SessionCardViewModel.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

import Combine
import Core
import Domain

final class SessionCardViewModel {

    // MARK: - Model & UI

    private let session: Session

    var title: String {
        return "Session \(session.index + 1)"
    }

    let lengthIconName: String = "session_duration"
    var lengthText: String {
        return "\(session.length) min"
    }

    var difficultyImage: String {
        return "intensity_\(session.difficulty.rawValue.lowercased())_dark"
    }

    var difficultyText: String {
        return session.difficulty.rawValue.capitalizingFirstLetter
    }

    var quote: String {
        return "\"\(session.quote)\""
    }

    var quoteAuthor: String {
        return session.quoteAuthor
    }

    var ctaButtonText: String {
        return "Did It"
    }

    var isDisplayingCompletedIcon: Bool {
        return defaults.integer(for: .latestCompletedSessionIndex) ?? 0 >= session.index
    }

    var completedIconName: String {
        return "scroller_checkmark"
    }

    // MARK: - Combine

    private let sessionStartPressedSubject = PassthroughSubject<Void, Never>()
    var sessionStartPressed: AnyPublisher<Void, Never> {
        sessionStartPressedSubject.eraseToAnyPublisher()
    }

    // MARK: - LifeCycle

    init(session: Session) {
        self.session = session
    }

    func ctaButtonTapped() {
        sessionStartPressedSubject.send()
    }
}
