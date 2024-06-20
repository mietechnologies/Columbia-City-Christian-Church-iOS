//
//  Dashboard.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

struct Dashboard: View {
    
    @State private var tabOptions: [ScrollingTabModel] = [
        .init(id: .dashboard),
        .init(id: .checkIn),
        .init(id: .tithe),
        .init(id: .sermonNotes),
        .init(id: .prayerChain),
        .init(id: .events)
    ]
    @State private var activeTab: ScrollingTabModel.Tab = .dashboard
    @State private var mainViewScrollState: ScrollingTabModel.Tab?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                ScrollingTabView(tabOptions: $tabOptions, selectedTab: $activeTab)
                    .onChange(of: activeTab) { _, newValue in
                        mainViewScrollState = newValue
                    }
                
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(tabOptions) { tab in
                                screen(for: tab.id)
                                    .frame(width: size.width, height: size.height)
                                    .contentShape(Rectangle())
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $mainViewScrollState)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
                    .toolbarBackground(.navigationBarBackground, for: .navigationBar)
                    .background(.white)
                    .onChange(of: mainViewScrollState) { _, newValue in
                        if let newValue {
                            activeTab = newValue
                        }
                    }
                }
                .navigationTitle("Columbia City Christian Church")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        ChurchButton {
                            withAnimation(.snappy) {
                                activeTab = .dashboard
                            }
                        }
                        .padding(.bottom, 15)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        CircularImageButton(name: "Test") {
                            // Nothing
                        }
                        .padding(.bottom, 15)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func screen(for tab: ScrollingTabModel.Tab) -> some View {
        switch tab {
        case .dashboard:
            AboutChurchScreen()
        default:
            Text(tab.rawValue)
        }
    }
    
}

struct TestView: View {
    var body: some View {
        Text("Hello World!")
    }
}

#Preview {
    Dashboard()
}
