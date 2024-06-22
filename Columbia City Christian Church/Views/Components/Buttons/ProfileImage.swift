//
//  ProfileImage.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/20/24.
//

import SwiftUI
import PhotosUI

struct ProfileImage: View {
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var photo: Image?
    @State private var uiImage: UIImage?
    @State private var photoCropMode = false
    
    var action: () -> Void
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            
            ZStack(alignment: .center) {
                if let photo {
                    photo
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                }
                
                // TODO: Update with AboutChurchView
                PhotosPicker("Edit", selection: $avatarItem, matching: .images)
                    .font(.body)
                    .tracking(2)
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.5))
                    .padding(.top, size.height * 0.65)
            }
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                action()
            }
            .shadow(color: .black.opacity(0.5), radius: 3, x: 3, y: 3)
        }
        .onChange(of: avatarItem) { _, _ in
            Task {
                if let loaded = try? await avatarItem?.loadTransferable(type: Data.self) {
                    uiImage = UIImage(data: loaded)
                    photoCropMode.toggle()
                }
            }
        }
        .sheet(isPresented: $photoCropMode, content: {
            ImageCropSheet(photo: $uiImage) { image in
                photo = Image(uiImage: image)
            }
            .interactiveDismissDisabled()
        })
    }
}

#Preview {
    ProfileImage {
        print("Hello World!")
    }
        .frame(width: 300, height: 300)
}
