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
                
                ScrollingTabView(tabOptions: $tabOptions, currentTab: $activeTab)
                    .padding(.horizontal, 5)
                    .onChange(of: activeTab) { _, newValue in
                        mainViewScrollState = newValue
                    }
                
                GeometryReader { proxy in
                    let size = proxy.size
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 0) {
                            ForEach(tabOptions) { tab in
                                tab.screen()
                                    .frame(width: size.width, height: size.height)
                                    .contentShape(Rectangle())
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $mainViewScrollState)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
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
                            // Nothing
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        CircularImageButton(name: "Test") {
                            // Nothing
                        }
                    }
                }
            }
            .background(.navigationBarBackground)
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
