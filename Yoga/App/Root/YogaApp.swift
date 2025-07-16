//
//  YogaApp.swift
//  Yoga
//
//  Created by Itay Gervash on 16/07/2025.
//

import SwiftUI

@main
struct YogaApp: App {
    @State private var selectedTab: AppTab = .plan
    private let container = AppContainer()

    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor.white.withAlphaComponent(0.8)  // or any custom UIColor

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }

    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                ForEach(AppTab.allCases, id: \.self) { tab in
                    Tab(tab.title, image: tabImage(tab), value: tab) {
                        tabView(tab)
                            .tag(tab)
                            .id(UUID())
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func tabView(_ tab: AppTab) -> some View {
        switch tab {
        case .plan:
            container.planContainer.sessionsView()
        default:
            Color.white.ignoresSafeArea()
        }
    }

    private func tabImage(_ tab: AppTab) -> String {
        tab.iconName(
            isSelected: selectedTab == tab
        )
    }
}
