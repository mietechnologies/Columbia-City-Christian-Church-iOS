//
//  TestView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

struct TestView: View {
    @Environment(PageNavigator<TestRoute>.self) private var nav

    var body: some View {
        Button(nav.visibleID ?? "Unknown") {
            print(nav.stack.count)
            nav.push(.about)
        }
    }
}
