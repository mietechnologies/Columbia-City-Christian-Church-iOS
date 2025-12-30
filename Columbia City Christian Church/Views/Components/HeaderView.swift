//
//  HeaderView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String
    let menuAction: (() -> Void)?
    let secondaryAction: (() -> Void)?
    
    init(_ title: String, menuAction: (() -> Void)? = nil, secondaryAction: (() -> Void)? = nil) {
        self.title = title
        self.menuAction = menuAction
        self.secondaryAction = secondaryAction
    }
    
    var body: some View {
        ZStack {
            Color.main
                .ignoresSafeArea(edges: .top)
                .frame(height: 60)
                .shadow(color: .black.opacity(0.6), radius: 5, y: 2)
            
            HStack {
                Button {
                    menuAction?()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                }
                .frame(width: 30, height: 25)
                .foregroundStyle(Color.textSecondary)
                .padding(.leading)
                .opacity(menuAction.isNil ? 0 : 1)
                
                
                Spacer()
                
                Text(title)
                    .themeStyle(.header, fontColor: .textSecondary)
                
                Spacer()
                
                Button {
                    print("Secondary Button")
                } label: {
                    Image(systemName: "person")
                        .resizable()
                }
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.textSecondary)
                .padding(.trailing)
                .opacity(secondaryAction.isNil ? 0 : 1)
            }
        }
        .zIndex(1)
    }
}

#Preview {
    VStack(spacing: 0) {
        HeaderView("Header") {
            print("Menu Action")
        } secondaryAction: {
            print("Secondary Action")
        }

        
        Color.background
            .ignoresSafeArea(edges: .bottom)
            .frame(height: .infinity)
    }
}
