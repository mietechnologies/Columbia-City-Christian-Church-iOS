//
//  ChurchButton.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

struct ChurchButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Image("Church Icon")
                    .resizable()
                    .scaledToFit()
                    .tint(
                        RadialGradient(
                            colors: [.logoSecondary, .logoTertiary, .logoPrimary],
                            center: .top,
                            startRadius: 20 * 0.15,
                            endRadius: 40
                        )
                    )
                    .frame(width: 40, height: 40)
                
                Image("Church Icon")
                    .resizable()
                    .scaledToFit()
                    .tint(
                        LinearGradient(
                            colors: [.clear, .clear, .black.opacity(0.3)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 40, height: 40)
            }
        }

    }
}

#Preview {
    ChurchButton {
        // Nothing
    }
}
