//
//  MenuButton.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2026.02.18.
//

import SwiftUI

struct MenuButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "line.3.horizontal")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(Color.textSecondary)
        }
    }
}
