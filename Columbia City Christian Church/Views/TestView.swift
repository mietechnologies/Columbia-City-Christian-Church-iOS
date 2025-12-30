//
//  TestView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var nav: PageNavigator<TestRoute>
    
    var body: some View {
        Button(nav.visibleID!) {
            print(nav.stack.count)
            nav.push(.about)
        }
    }
}
