//
//  MenuView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

struct MenuView<T>: View where T: CaseIterable & RawRepresentable & Hashable, T.RawValue == String {
    @Binding var isPresented: Bool
    @Binding var selectedItem: T
    var edge: Edge = .leading
    var width: CGFloat = 280
    
    var labelFor: (T) -> String = { $0.rawValue }
    var iconFor: (T) -> Image? = { _ in nil }
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    private var alignment: Alignment {
        edge == .leading ? .leading : .trailing
    }
    
    var body: some View {
        ZStack(alignment: alignment) {
            // Dimmed Backdrop
            if isPresented {
                Rectangle()
                    .fill(.thinMaterial)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture { withAnimation { isPresented = false } }
                    .accessibilityHidden(true)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                VStack {
                    
                    ScrollView {
                        VStack {
                            Image("ChurchLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .padding(.bottom, 5)
                            
                            Text("Columbia City")
                                .themeStyle(.body, fontColor: .textSecondary)
                                .fontWeight(.semibold)
                            
                            Text("Christian Church")
                                .themeStyle(.body2, fontColor: .textSecondary)
                                .fontWeight(.bold)
                        }
                        .padding(.bottom, 10)
                        .padding(.trailing)
                        
                        ForEach(Array(T.allCases), id: \.self) { item in
                            Button {
                                selectedItem = item
                                withAnimation { isPresented = false }
                            } label: {
                                HStack(spacing: 12) {
                                    iconFor(item)
                                    
                                    Text(labelFor(item))
                                        .themeStyle(.mediumHeader, fontColor: .textSecondary)
                                        .fontWeight(.regular)
                                        .foregroundStyle(.primary)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.trailing)
                                .padding(.vertical, 2)
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                            
                            Divider()
                                .overlay(Color.white)
                                .padding(.horizontal)
                        }
                    }
                    
                    Spacer(minLength: 0)
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                            .padding(.leading)
                            .padding(.top)
                        
                        Text("Sign In")
                            .themeStyle(.body2, fontColor: .textSecondary)
                            .fontWeight(.semibold)
                            .padding(.leading, 10)
                            .padding(.top)
                        
                        Spacer()
                    }
                    .frame(height: 75)
                    .background(Color.main)
                }
                .padding(.top, safeAreaInsets.top)
                .padding(.bottom, safeAreaInsets.bottom)
                
            }
            .frame(width: width)
            .background(Color.tertiary)
            .ignoresSafeArea()
            .shadow(radius: 12)
            .offset(x: panelOffsetX)
            .transition(.move(edge: edge))
            .accessibilityElement(children: .contain)
        }
        .animation(.easeIn(duration: 0.2), value: isPresented)
    }
    
    private var panelOffsetX: CGFloat {
        guard !isPresented else { return 0 }
        return edge == .leading ? -width - 75 : width
    }
    
}

#Preview {
    MenuView<MenuItem>(isPresented: .constant(true), selectedItem: .constant(.home))
}
