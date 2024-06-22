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
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(tabOptions) { tab in
                    ScrollingTabItem(selectedTab: $selectedTab, tab: tab, namespace: namespace)
                        .padding(.horizontal, 10)
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetLayout()
        .background(.navigationBarBackground)
        .scrollPosition(id: .init(get: {
            return selectedTab
        }, set: { _ in
        }), anchor: .center)
    }
}

// #Preview {
//    ScrollingTabView()
// }
