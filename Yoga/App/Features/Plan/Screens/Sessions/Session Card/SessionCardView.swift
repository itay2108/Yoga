//
//  SessionCardView.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

import SwiftUI

struct SessionCardView: View {

    var viewModel: SessionCardViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            titleView
                .padding(.bottom, 36)
            quoteView
                .padding(.bottom, 28)

            ctaView
        }
        .padding([.horizontal, .top], 24)
        .padding(.bottom, 18)
        .background(
            background
        )
    }

    // MARK: - Title View

    private var titleView: some View {
        VStack(spacing: 12) {

            HStack {
                Spacer()
                if viewModel.isDisplayingCompletedIcon {
                    Image(viewModel.completedIconName)
                        .renderingMode(.template)
                        .resizedToFill(width: 16, height: 16)
                        .foregroundStyle(.primary1)
                }

                Text(verbatim: viewModel.title)
                    .appFont(.medium, size: 18)
                    .foregroundStyle(.neutral1)

                if viewModel.isDisplayingCompletedIcon {
                    Spacer().frame(width: 16)
                }
                Spacer()
            }
            .overlay {
                premiumView
            }

            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray.opacity(0.2))

            sessionSpecView
        }
    }

    private var sessionSpecView: some View {
        HStack(spacing: 20) {
            Spacer()
            sessionTimeView
            sessionDifficultyView
            Spacer()
        }
        .lineLimit(1)
    }

    private var sessionTimeView: some View {
        HStack(alignment: .lastTextBaseline, spacing: 6) {
            Image(viewModel.lengthIconName)
                .resizedToFit(height: 12)
            Text(viewModel.lengthText)
                .appFont()
                .foregroundStyle(Color(.neutral1))
        }
    }

    private var sessionDifficultyView: some View {
        HStack(alignment: .center, spacing: 2) {
            Image(viewModel.difficultyImage)
                .resizedToFit(height: 18)
                .padding(.bottom, 3)

            Text(viewModel.difficultyText)
                .appFont()
                .foregroundStyle(Color(.neutral1))
        }
    }

    // MARK: - Quote View

    private var quoteView: some View {
        VStack(spacing: 16) {
            Text(viewModel.quote)
                .appFont(size: 15)
                .frame(height: 36)

            Text(viewModel.quoteAuthor)
                .appFont(size: 12)
        }
        .foregroundStyle(Color(.neutral1))
        .multilineTextAlignment(.center)
    }

    // MARK: - CTA

    private var ctaView: some View {
        CTAButton(title: viewModel.ctaButtonText) {
            viewModel.ctaButtonTapped()
        }
    }

    // MARK: - Helper Views

    private var background: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.white.opacity(0.8))
    }

    private var premiumView: some View {
        HStack {
            Spacer()

            if viewModel.isPremium {
                Image(viewModel.premiumIconName)
                    .renderingMode(.template)
                    .resizedToFit(height: 18)
                    .padding(.trailing, 4)
                    .padding(.bottom, 2)
                    .foregroundStyle(.gray.opacity(0.5))
            }
        }
    }
}

#Preview {
    ZStack {

        Color.gray.opacity(0.5).ignoresSafeArea()

        SessionCardView(
            viewModel: .init(
                session: .init(
                    index: 0,
                    length: 7,
                    quoteAuthor: "Itay Gervash",
                    quote: "Hello World, this is a message to all human beings telling you to start doing yoga!",
                    chapterName: "Chaturanga!",
                    chapter: 1,
                    difficulty: .easy
                )
            )
        )
        .padding(16)
    }
}
