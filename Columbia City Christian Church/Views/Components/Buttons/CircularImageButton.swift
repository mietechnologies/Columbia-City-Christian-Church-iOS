//
//  CircularImageButton.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

struct CircularImageButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image("Test")
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }

    }
}

#Preview {
    CircularImageButton {
        // Nothing
    }
}
