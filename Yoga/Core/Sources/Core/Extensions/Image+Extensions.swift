//
//  Image+Extensions.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import SwiftUI

public extension Image {
    func resizedToFit(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height, alignment: alignment)
    }

    func resizedToFill(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height, alignment: alignment)
    }

    init?(data: Data) {
        guard let uiImage = UIImage(data: data) else {
            return nil
        }
        self = Image(uiImage: uiImage)
    }
}
