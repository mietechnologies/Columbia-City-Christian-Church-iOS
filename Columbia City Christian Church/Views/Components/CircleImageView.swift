//
//  CircularImageView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

struct CircleImageView: View {
    
    private var assetName: String? = nil
    private var assetUrl: URL? = nil
    
    init(name: String) {
        self.assetName = name
    }
    
    init(url: URL?) {
        self.assetUrl = url
    }
    
    var body: some View {
        imageView()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
    }
    
    @ViewBuilder
    func imageView() -> some View {
        if let assetUrl {
            AsyncImage(url: assetUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.gray)
            }
        } else if let assetName {
            Image(assetName)
                .resizable()
                .scaledToFill()
        } else {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.gray)
        }
    }
}

 #Preview("Asset Name") {
    CircleImageView(name: "Test")
 }

 #Preview("Asset URL") {
    CircleImageView(url: URL(string: "https://tinyurl.com/yck2995j"))
 }

#Preview("No Asset") {
    CircleImageView(url: nil)
}
