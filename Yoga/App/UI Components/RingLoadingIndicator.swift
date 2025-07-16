//
//  RingLoadingIndicator.swift
//  SwifterUI
//
//  Created by Itay Gervash on 10/06/2024.
//

import Core
import SwiftUI

struct RingLoadingIndicator: View {

    @State private var rotation: CGFloat = 0.0
    @State private var trimmedPart: CGFloat = 0.73

    var color: Color
    var secondaryColor: Color

    var size: RingLoadingIndicatorSize = .normal

    public init(
        color: Color = .accentColor,
        secondaryColor: Color = .gray.opacity(0.3),
        size: RingLoadingIndicatorSize = .normal
    ) {
        self.color = color
        self.secondaryColor = secondaryColor
        self.size = size
    }

    private var strokeWidth: CGFloat {
        return (size.frame / 15).clamped(from: 2)
    }

    public var body: some View {
        ZStack {
            staticStroke
            rotatingStroke
        }
        .frame(height: size.frame)
        .padding(strokeWidth / 2)
        .onAppear {
            startAnimating()
        }
    }

    private var staticStroke: some View {
        Circle()
            .stroke(lineWidth: strokeWidth)
            .foregroundColor(secondaryColor)
    }

    private var rotatingStroke: some View {
        Circle()
            .trim(from: 0, to: trimmedPart)
            .stroke(
                style:
                    StrokeStyle(
                    lineWidth: strokeWidth,
                    lineCap: .round
                )
            )
            .foregroundColor(color)
            .rotationEffect(.degrees(rotation), anchor: .center)
    }

    private func startAnimating() {
        performAnimation()

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            Task { @MainActor in
                performAnimation()
            }
        }
    }

    private func performAnimation() {
        withAnimation(.easeInOut(duration: 1)) {
            if trimmedPart < 0.5 {
                trimmedPart = 0.9
            } else if trimmedPart <= 0.5 {
                trimmedPart = 0.1
            } else {
                trimmedPart += CGFloat.random(in: (-trimmedPart + 0.1)...(0.9 - trimmedPart))
            }

            rotation += 360
        }
    }
}

extension RingLoadingIndicator {
    enum RingLoadingIndicatorSize {
        case small
        case normal
        case large
        case extraLarge
        case custom(frameSize: Double)

        var frame: Double {
            switch self {
            case .small:
                return 16
            case .normal:
                return 30
            case .large:
                return 48
            case .extraLarge:
                return 64
            case .custom(let frameSize):
                return frameSize
            }
        }
    }
}
#Preview {
    ZStack {
        Color(.darkText).ignoresSafeArea()

        VStack {
            RingLoadingIndicator(size: .small)
            RingLoadingIndicator(size: .normal)
            RingLoadingIndicator(size: .large)
            RingLoadingIndicator(size: .extraLarge)
        }
    }
}
