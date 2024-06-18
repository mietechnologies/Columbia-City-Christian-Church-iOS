//
//  ChurchLogoView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

struct ChurchLogoView: View {
    var body: some View {
        GeometryReader { proxy in
            let measurement = proxy.size.width > proxy.size.height ? proxy.size.height : proxy.size.width
            let radius = measurement / 2
            let startRadius = radius * 0.15
            
            ChurchIconShape()
                .fill(RadialGradient(colors: [.logoSecondary, .logoTertiary, .logoPrimary],
                                     center: .top,
                                     startRadius: startRadius,
                                     endRadius: measurement))
                .fill(LinearGradient(colors: [.clear, .clear, .black.opacity(0.3)],
                                     startPoint: .top,
                                     endPoint: .bottom))
        }
        .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    ChurchLogoView()
        .frame(width: 200, height: 200)
}
