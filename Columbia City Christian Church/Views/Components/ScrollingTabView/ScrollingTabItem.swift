//
//  ScrollingTabItem.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/19/24.
//

import SwiftUI

struct ScrollingTabItem: View {
    
    @Binding var currentTab: ScrollingTabModel.Tab
    var tab: ScrollingTabModel
    let namespace: Namespace.ID
    
    var body: some View {
        VStack(spacing: 3) {
            Button {
                withAnimation(.snappy) {
                    self.currentTab = tab.id
                }
            } label: {
                Text(tab.id.rawValue)
                    .themeStyle(.body)
            }
            .buttonStyle(.plain)
            
            if currentTab == tab.id {
                Color.textPrimary
                    .frame(height: 2)
                    .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
            } else {
                Color.clear
                    .frame(height: 2)
            }
        }
        .padding(.bottom, 12)
        .animation(.spring(), value: currentTab)
    }
}
