//
//  Font+AppFont.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

import SwiftUI

public extension Font {
    static func appFont(_ style: Font.AppFontStyle = .book, size: CGFloat = 16) -> Font {
        switch style {
        case .book:
            return .custom("Kohinoor-Book", size: size)
        case .medium:
            return .custom("Kohinoor-Medium", size: size)
        }
    }
}
