//
//  ContentView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/17/24.
//

import SwiftUI

struct ContentView: View {

    @State private var showMenu = false
    @State private var selection: MenuItem = .home

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if selection != .events {
                    HeaderView(selection.rawValue, menuAction: { withAnimation { showMenu = true } })
                }

                switch selection {
                case .home:
                    AboutChurchScreen()
                case .events:
                    EventsScreen(menuAction: { withAnimation { showMenu = true } })
                default:
                    TestView()
                }
            }
            .menu(isPresented: $showMenu, selectedItem: $selection)
        }
    }
}

#Preview {
    ContentView()
}
