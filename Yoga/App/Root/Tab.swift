//
//  Tab.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

enum AppTab: String, CaseIterable {
    case plan = "myplan"
    case library
    case achievements
    case more

    var title: String {
        switch self {
        case .plan:
            return "My Plan"
        case .library:
            return "Library"
        case .achievements:
            return "Milestones"
        case .more:
            return "More"
        }
    }

    func iconName(isSelected: Bool) -> String {
        let suffix: String = {
            isSelected ? "selected" : "unselected"
        }()

        return "tab_bar_\(rawValue)_\(suffix)"
    }

}
