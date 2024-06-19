//
//  ScrollingTabView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/19/24.
//

import SwiftUI

struct ScrollingTabView: View {
    
    @Binding var tabOptions: [ScrollingTabModel]
    @Binding var selectedTab: ScrollingTabModel.Tab
    @Namespace var namespace
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.top, 10)
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(tabOptions) { tab in
                        ScrollingTabItem(selectedTab: $selectedTab, tab: tab, namespace: namespace)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .background(.navigationBarBackground)
            .safeAreaPadding(.horizontal, 10)
        }
        .scrollPosition(id: .init(get: {
            return selectedTab
        }, set: { _ in
        }), anchor: .center)
    }
}

// #Preview {
//    ScrollingTabView()
// }
