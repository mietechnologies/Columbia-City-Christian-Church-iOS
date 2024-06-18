//
//  CircularImageButton.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

struct CircularImageButton: View {
    
    private var assetName: String? = nil
    private var assetUrl: URL? = nil
    private let action: () -> Void
    
    init(name: String, action: @escaping () -> Void) {
        self.assetName = name
        self.action = action
    }
    
    init(url: URL?, action: @escaping () -> Void) {
        self.assetUrl = url
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            if let assetUrl {
                AsyncImage(url: assetUrl) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                } placeholder: {
                    Image("Test")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
            } else if let assetName {
                Image(assetName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
        }

    }
}

#Preview("Asset Name") {
    CircularImageButton(name: "Test") {
        // Nothing
    }
}

#Preview("Asset URL") {
    CircularImageButton(url:URL(string: "https://tinyurl.com/yck2995j")) {
        // Nothing
    }
}
