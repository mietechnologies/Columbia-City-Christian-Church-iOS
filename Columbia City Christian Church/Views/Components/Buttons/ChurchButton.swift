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
            ChurchLogoView()
                .frame(width: 40, height: 40)
        }

    }
}

#Preview {
    ChurchButton {
        // Nothing
    }
}
