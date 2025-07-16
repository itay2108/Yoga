//
//  CGPoint+Extensions.swift
//
//
//  Created by Itay Gervash on 24/02/2024.
//

import SwiftUI

public extension CGPoint {
    func isIn(frame: CGRect) -> Bool {
        let xRange = frame.minX...frame.maxX
        let yRange = frame.minY...frame.maxY

        return xRange.contains(self.x) && yRange.contains(self.y)
    }
}
