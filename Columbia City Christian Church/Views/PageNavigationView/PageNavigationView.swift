//
//  PageNavigationView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

struct PageNavigationView<Route: Identifiable & Hashable, Page: View>: View {
    @State var nav: PageNavigator<Route>
    private let pageBuilder: (Route) -> Page

    private let swipeThreshold: CGFloat = 60     // points
    private let edgeThreshold: CGFloat = 30

    init(route: Route, @ViewBuilder page: @escaping (Route) -> Page) {
        _nav = .init(initialValue: PageNavigator(root: route))
        self.pageBuilder = page
    }

    init(nav: PageNavigator<Route>, @ViewBuilder page: @escaping (Route) -> Page) {
        _nav = .init(initialValue: nav)
        self.pageBuilder = page
    }

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(nav.stack) { route in
                        pageBuilder(route)
                            .frame(width: size.width, height: size.height)
                            .contentShape(Rectangle())
                            .id(route.id)
                            .environment(nav)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.paging)
            .scrollIndicators(.hidden)
            .highPriorityGesture(swipeGesture)
            .scrollPosition(id: $nav.visibleID)
        }
    }
    
    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 10, coordinateSpace: .local)
            .onEnded { value in
                // Check if gesture started near the left edge
                guard value.startLocation.x < edgeThreshold else { return }
                
                let dx = value.translation.width
                // Only handle right swipes (swiping to the right)
                if dx > swipeThreshold {
                    _ = nav.pop()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
    }
}
