//
//  SessionsView.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

import Core
import SwiftUI

struct SessionsView: View {
    private typealias ViewModel = SessionsViewModel
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: SessionsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        mainContent
            .onAppear {
                Task {
                    await viewModel.loadSessions()
                }
            }
            .alert(viewModel.infoPopupTitle, isPresented: $viewModel.isShowingInfoPopup) {
                Button("Ok", role: .none) {}
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(viewModel.infoPopupMessage)
            }
    }

    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.loadingState {
        case .idle:
            Color.clear
        case .loading:
            loadingView
        case .loaded(let sessions):
            planView(sessions: sessions)
        case .failed:
            errorView
        }
    }

    private var loadingView: some View {
        VStack {
            Spacer()
            RingLoadingIndicator(size: .large)
            Spacer()
        }
    }

    private func planView(sessions: ViewModel.Model) -> some View {
        ZStack {
            background

            VStack {
                planHeaderView()
                    .padding(.top, 48)
                Spacer()
                cardScrollView(sessions)
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func planHeaderView() -> some View {
        VStack(spacing: 8) {
            Text(viewModel.title)
                .appFont(.medium)
                .padding(.bottom, 4)
                .overlay(content: {
                    VStack {
                        Spacer()
                        Rectangle()
                            .frame(height: 1)
                    }
                })
                .padding(.bottom, 4)

            if let currentChapterTitle = viewModel.currentChapterTitle {
                Text(currentChapterTitle)
                    .appFont(size: 14)
            }

            if let currentChapterName = viewModel.currentChapterName {
                Text(currentChapterName)
                    .appFont(.medium, size: 14)
            }
        }
        .frame(maxWidth: .infinity)
        .overlay(alignment: .topLeading) {
            infoButtonView
                .padding(.horizontal, 36)
        }
    }

    private var infoButtonView: some View {

        Button {
            viewModel.isShowingInfoPopup = true
        } label: {
            Image("plan_info")
        }
    }

    @ViewBuilder
    private var background: some View {
        if let imageName = viewModel.backgroundImageName {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }

    private func cardScrollView(_ sessions: ViewModel.Model) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                Spacer().frame(width: 56)
                ForEach(sessions, id: \.index) { session in
                    SessionCardView(viewModel: viewModel.cardViewModel(for: session))
                        .frame(width: UIScreen.main.bounds.width - 100)
                }
                Spacer().frame(width: 56)

            }
        }
    }

    private func sessionCard(_ session: ViewModel.Model.Element) -> some View {
        ZStack {

        }
    }

    private var errorView: some View {
        Text("Oops! Something went wrong.")
    }
}

#Preview {
    AppContainer().planContainer.sessionsView()
}
