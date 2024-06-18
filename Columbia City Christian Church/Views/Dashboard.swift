//
//  Dashboard.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

struct Dashboard: View {
    var body: some View {
        NavigationStack {
            Text("Hello World!")
                .navigationTitle("Columbia City Christian Church")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        ChurchButton {
                            // Nothing
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        CircularImageButton(name: "Test") {
                            // Nothing
                        }
                    }
                }
        }
    }
}

#Preview {
    Dashboard()
}
