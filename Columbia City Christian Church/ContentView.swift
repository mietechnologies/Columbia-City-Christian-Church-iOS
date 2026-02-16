//
//  ContentView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/17/24.
//

import SwiftUI

enum TestRoute: Hashable, Identifiable {
    case home
    case about
    
    var id: String {
        switch self {
        case .home: return "Home"
        case .about: return "About"
        }
    }
}

struct ContentView: View {
    
    @State private var showMenu = false
    @State private var selection: MenuItem = .home
    @State private var eventNav = PageNavigator(root: EventRoute.list)

    // MARK: - Body

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                headerView

                switch selection {
                case .home:
                    AboutChurchScreen()
                case .events:
                    EventsScreen(nav: eventNav)
                case .directory:
                    PageNavigationView(route: TestRoute.home, page: navigate(to:))
                case .tithe:
                    PageNavigationView(route: TestRoute.home, page: navigate(to:))
                default:
                    PageNavigationView(route: TestRoute.home, page: navigate(to:))
                }
            }
            .menu(isPresented: $showMenu, selectedItem: $selection)
        }
    }

    // MARK: - Subviews

    @ViewBuilder
    private var headerView: some View {
        if selection == .events && eventNav.canGoBack {
            HeaderView(selection.rawValue, leadingIcon: "chevron.left", menuAction: {
                eventNav.pop()
            })
        } else {
            HeaderView(selection.rawValue, menuAction: { withAnimation { showMenu = true } })
        }
    }

    @ViewBuilder
    func navigate(to route: TestRoute) -> some View {
        switch route {
        case .home:
            TestView()
        case .about:
            Text("About")
        }
    }
}

#Preview {
    ContentView()
}
