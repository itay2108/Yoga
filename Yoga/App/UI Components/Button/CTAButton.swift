//
//  CTAButton.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

import SwiftUI

public struct CTAButton: View {
    public var title: String
    public var action: () -> Void

    public var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .lineLimit(1)
                .font(.appFont(size: 18))
                .padding(.horizontal, 52)
                .padding(.vertical, 14)
                .foregroundStyle(.black)
                .background(
                    RoundedRectangle(cornerRadius: 64)
                        .fill(Color(.primary1))
                )
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CTAButton(
        title: "Start",
        action: { print("Button pressed") }
    )
}
