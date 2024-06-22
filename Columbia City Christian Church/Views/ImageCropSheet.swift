//
//  ImageCropSheet.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/21/24.
//

import SwiftUI

struct ImageCropSheet: View {

    @Environment(\.dismiss) private var dismiss
    
    private let inset: CGFloat = 15
    private let screenRatio = UIScreen.main.bounds.width / UIScreen.main.bounds.height
    
    @Binding var photo: UIImage?
    var updateImage: (UIImage) -> Void
    
    @State private var inputImage: UIImage?
    @State private var inputW: CGFloat = 750
    @State private var inputH: CGFloat = 1336
    @State private var aspectRatio: CGFloat = 0.0
    
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    @State private var horizontalOffset: CGFloat = 0.0
    @State private var verticalOffset: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            ZStack {
                Color.black.opacity(0.8)
                if let photo {
                    Image(uiImage: photo)
                        .resizable()
                        .scaleEffect(finalAmount + currentAmount)
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                        .onAppear(perform: {
                            inputW = photo.size.width
                            inputH = photo.size.height
                            aspectRatio = inputW / inputH
                        })
                }
            }
            
            Rectangle()
                .fill(.black).opacity(0.55)
                .mask(holeShapeMask().fill(style: .init(eoFill: true)))
            
            VStack {
                Text("Move and Scale")
                    .foregroundStyle(.white)
                    .padding(.top, 50)
                
                Spacer()
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    
                    Spacer()
                    
                    Button {
                        save()
                    } label: {
                        Text("Save")
                    }
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
            }
            .padding()
        }
        .ignoresSafeArea(.all)
        .gesture(
            MagnifyGesture()
                .onChanged({ amount in
                    self.currentAmount = amount.magnification - 1
                })
                .onEnded({ _ in
                     self.finalAmount += self.currentAmount
                     self.currentAmount = 0
                     repositionImage()
                })
        )
        .simultaneousGesture(
            DragGesture()
                .onChanged({ value in
                     self.currentPosition = CGSize(
                        width: value.translation.width + self.newPosition.width,
                        height: value.translation.height + self.newPosition.height
                     )
                })
                .onEnded({ value in
                     self.currentPosition = CGSize(
                        width: value.translation.width + self.newPosition.width,
                        height: value.translation.height + self.newPosition.height
                     )
                    self.newPosition = currentPosition
                     repositionImage()
                })
        )
        .gesture(
            TapGesture(count: 2)
                .onEnded({
                     resetImageOriginAndScale()
                })
        )
    }
    
    private func holeShapeMask() -> Path {
        let screenSize = UIScreen.main.bounds.size
        let rect = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        let insetRect = CGRect(
            x: inset,
            y: inset,
            width: screenSize.width - (inset * 2),
            height: screenSize.height - (inset * 2)
        )
        var shape = Rectangle().path(in: rect)
        shape.addPath(Circle().path(in: insetRect))
        return shape
    }
    
    private func resetImageOriginAndScale() {
        withAnimation {
            if aspectRatio >= screenRatio {
                inputW = UIScreen.main.bounds.width
                inputH = inputW / aspectRatio
            } else {
                inputH = UIScreen.main.bounds.height
                inputW = inputH * aspectRatio
            }
            currentAmount = 0
            finalAmount = 1
            currentPosition = .zero
            newPosition = .zero
        }
    }
    
    private func repositionImage() {
        let screenSize = UIScreen.main.bounds.size
        
        if aspectRatio > screenRatio {
            inputW = screenSize.width * finalAmount
            inputH = inputW / aspectRatio
        } else {
            inputH = screenSize.height * finalAmount
            inputW = inputH * aspectRatio
        }
        
        horizontalOffset = (inputW - screenSize.width) / 2
        verticalOffset = (inputH - screenSize.width) / 2
        
        if finalAmount > 4.0 {
            withAnimation {
                finalAmount = 4
            }
        }
        
        repositionBasedOnWidth()
        repositionBasedOnHeight()
        
        if inputW <= UIScreen.main.bounds.width && aspectRatio > screenRatio {
            resetImageOriginAndScale()
        }
        if inputH <= UIScreen.main.bounds.height && aspectRatio < screenRatio {
            resetImageOriginAndScale()
        }
    }
    
    private func repositionBasedOnWidth() {
        let screenSize = UIScreen.main.bounds.size
        
        if inputW >= screenSize.width {
            if newPosition.width > horizontalOffset {
                withAnimation(.easeInOut) {
                    newPosition = .init(width: horizontalOffset + inset, height: newPosition.height)
                    currentPosition = .init(width: horizontalOffset + inset, height: currentPosition.height)
                }
            }
            
            if newPosition.width < (horizontalOffset * -1) {
                withAnimation(.easeInOut) {
                    newPosition = .init(width: (horizontalOffset * -1) - inset, height: newPosition.height)
                    currentPosition = .init(width: (horizontalOffset * -1 - inset), height: currentPosition.height)
                }
            }
        } else {
            withAnimation(.easeInOut) {
                newPosition = .init(width: 0, height: newPosition.height)
                currentPosition = .init(width: 0, height: newPosition.height)
            }
        }
    }
    
    private func repositionBasedOnHeight() {
        let screenSize = UIScreen.main.bounds.size
        
        if inputH >= screenSize.width {
            if newPosition.height > verticalOffset {
                withAnimation(.easeInOut) {
                    newPosition = CGSize(width: newPosition.width, height: verticalOffset + inset)
                    currentPosition = CGSize(width: newPosition.width, height: verticalOffset + inset)
                }
            }
            
            if newPosition.height < ( verticalOffset * -1) {
                withAnimation(.easeInOut) {
                    newPosition = CGSize(width: newPosition.width, height: ( verticalOffset * -1) - inset)
                    currentPosition = CGSize(width: newPosition.width, height: ( verticalOffset * -1) - inset)
                }
            }
        } else {
            withAnimation(.easeInOut) {
                newPosition = CGSize(width: newPosition.width, height: 0)
                currentPosition = CGSize(width: newPosition.width, height: 0)
            }
        }
    }
    
    private func save() {
        let screenSize = UIScreen.main.bounds.size
        if let photo {
            let scale = (photo.size.width) / inputW
            
            let xPos = (((inputW - screenSize.width) / 2) + inset + (currentPosition.width * -1)) * scale
            let yPos = (((inputH - screenSize.width) / 2) + inset + (currentPosition.height * -1)) * scale
            let radius = (screenSize.width - inset * 2) * scale
            
            if let croppedPhoto = photo.cropTo(CGRect(x: xPos, y: yPos, width: radius, height: radius)) {
                updateImage(croppedPhoto)
                dismiss()
            }
        }
    }
}

#Preview {
    ImageCropSheet(photo: .constant(UIImage(named: "Test")), updateImage: { _ in
        print("Test")
        
    })
}
