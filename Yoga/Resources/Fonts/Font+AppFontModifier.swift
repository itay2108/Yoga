//
//  Font+AppFontModifier.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

import SwiftUI

public struct AppFontModifier: ViewModifier {
    let style: Font.AppFontStyle
    let size: CGFloat

    public func body(content: Content) -> some View {
        let fontName: String = {
            switch style {
            case .book: return "Kohinoor-Book"
            case .medium: return "Kohinoor-Medium"
            }
        }()
        return content.font(.custom(fontName, size: size))
    }
}

public extension View {
    func appFont(_ style: Font.AppFontStyle = .book, size: CGFloat = 16) -> some View {
        self.modifier(AppFontModifier(style: style, size: size))
    }
}
