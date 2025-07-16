//
//  Haptics.swift
//  Core
//
//  Created by Itay Gervash on 16/07/2025.
//

import UIKit

@MainActor
public enum Haptics {

    // MARK: - Impact (light, medium, heavy, soft, rigid)

    public static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }

    public static func lightImpact() {
        impact(.light)
    }

    public static func mediumImpact() {
        impact(.medium)
    }

    public static func heavyImpact() {
        impact(.heavy)
    }

    public static func softImpact() {
        impact(.soft)
    }

    public static func rigidImpact() {
        impact(.rigid)
    }

    // MARK: - Notification (success, warning, error)

    public static func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }

    public static func success() {
        notification(.success)
    }

    public static func warning() {
        notification(.warning)
    }

    public static func error() {
        notification(.error)
    }

    // MARK: - Selection Changed

    public static func selectionChanged() {
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
}
