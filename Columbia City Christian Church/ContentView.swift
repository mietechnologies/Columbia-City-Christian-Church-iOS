//
//  ContentView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/17/24.
//

import MIENavigationView
import SwiftUI

struct ContentView: View {

    @State private var showMenu = false
    @State private var selection: MenuItem = .home
    @State private var navigator = MIENavigator(root: MenuItem.home)

    private var menuAction: () -> Void {
        { withAnimation { showMenu = true } }
    }

    var body: some View {
        Group {
            if selection == .events {
                EventsScreen(menuAction: menuAction)
            } else {
                MIENavigationView(navigator: navigator) { route in
                    switch route {
                    case .home:
                        AboutChurchScreen(menuAction: menuAction)
                    default:
                        TestView(menuAction: menuAction)
                    }
                }
                .ignoresSafeArea(.container, edges: .bottom)
            }
        }
        .onChange(of: selection) { _, newValue in
            guard newValue != .events else { return }
            navigator.replaceRoot(newValue)
        }
        .menu(isPresented: $showMenu, selectedItem: $selection)
    }
}

#Preview {
    ContentView()
}
