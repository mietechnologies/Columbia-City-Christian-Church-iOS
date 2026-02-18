//
//  TestView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import MIENavigationView
import SwiftUI

struct TestView: View {
    let menuAction: () -> Void

    var body: some View {
        Text("Coming Soon")
            .themeStyle(.mediumHeader, fontColor: .textSecondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background)
            .mieNavigationLeading {
                MenuButton(action: menuAction)
            }
            .mieNavigationBarBackground(Color.main)
    }
}
