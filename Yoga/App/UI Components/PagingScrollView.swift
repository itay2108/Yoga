//
//  PagingScrollView.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//


import SwiftUI
import Data

struct PagingScrollView<Item: Identifiable, Content: View, Indicator: View>: View {
    private let items: [Item]
    private let spacing: CGFloat = 10
    private let scaleDecrease: CGFloat = 0.95
    private let sideMargin: CGFloat = 0.05
    private let pageContent: (Item, Bool) -> Content
    private let indicatorContent: (Int) -> Indicator

    @GestureState private var dragOffset: CGFloat = 0
    @Binding var currentPage: Int

    private var currentPageCGFloat: CGFloat {
        CGFloat(currentPage)
    }

    init(
        currentPage: Binding<Int>,
        items: [Item],
        @ViewBuilder content: @escaping (Item, Bool) -> Content,
        @ViewBuilder indicator: @escaping (Int) -> Indicator
    ) {
        self.items = items
        self._currentPage = currentPage
        self.pageContent = content
        self.indicatorContent = indicator
    }

    var body: some View {
        GeometryReader { proxy in
            let totalWidth = proxy.size.width
            let totalHeight = proxy.size.height
            let sideSpacing = totalWidth * sideMargin
            let cardWidth = totalWidth - 2 * sideSpacing

            ZStack(alignment: .top) {
                scrollView(cardWidth: cardWidth, sideSpacing: sideSpacing)
                    .frame(height: totalHeight)

                VStack {
                    Spacer()
                    indicatorView(totalWidth: totalWidth, sideSpacing: sideSpacing)
                        .padding(.bottom, totalHeight * 0.1)
                }
            }
            .frame(width: totalWidth, height: totalHeight)
        }
    }

    @ViewBuilder
    private func scrollView(cardWidth: CGFloat, sideSpacing: CGFloat) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(Array(items.enumerated()), id: \.1.id) { index, item in
                    let relativeOffset = CGFloat(index) - currentPageCGFloat
                    let isCurrent = abs(relativeOffset) < 0.5
                    let scale = isCurrent ? 1.0 : scaleDecrease

                    pageContent(item, isCurrent)
                        .scaleEffect(scale)
                        .frame(width: cardWidth)
                        .animation(.spring(), value: currentPage)
                }
            }
            .padding(.horizontal, sideSpacing)
            .frame(maxHeight: .infinity, alignment: .center)
            .offset(x: -currentPageCGFloat * (cardWidth + spacing) + dragOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let velocity = value.predictedEndTranslation.width - value.translation.width
                        let predictedOffset = value.translation.width + velocity * 0.2
                        let pageWidth = cardWidth + spacing
                        let pageDelta = -predictedOffset / pageWidth
                        let newPage = (currentPageCGFloat + pageDelta).rounded()
                        currentPage = max(0, min(items.count - 1, Int(newPage)))
                    }
            )
        }
    }

    @ViewBuilder
    private func indicatorView(totalWidth: CGFloat, sideSpacing: CGFloat) -> some View {
        let indicatorWidth: CGFloat = totalWidth * 0.1
        let initialOffset = (totalWidth - indicatorWidth) / 2
        let pageRange = CGFloat(items.count)
        let dynamicOffset = -((currentPageCGFloat / pageRange) * (totalWidth - indicatorWidth))
        let offsetX = initialOffset + dynamicOffset + indicatorWidth

        ZStack(alignment: .leading) {
            HStack(spacing: 0) {
                ForEach(0..<items.count, id: \.self) { index in
                    indicatorContent(index)
                        .frame(width: indicatorWidth)
                }
            }
            .offset(x: offsetX)
            .animation(.easeInOut, value: currentPage)
        }
        .padding(.horizontal, sideSpacing)
        .frame(width: totalWidth)
        .padding(.vertical, 16)
        .background(
            Rectangle()
                .fill(Color.black.opacity(0.7))
        )
        .overlay {
            Image("scroller_frame")
        }
    }
}

#Preview {
    PagingScrollView(currentPage: .constant(0), items: try! DefaultPlanRepository().getSessions().throwErrors()) { item, isCurrent in
        SessionCardView(
            viewModel: .init(
                session: item
            )
        )
        .padding(16)

    } indicator: { index in
        Text("\(index)")
            .foregroundStyle(.white)
            .appFont(size: 18)
    }
}
