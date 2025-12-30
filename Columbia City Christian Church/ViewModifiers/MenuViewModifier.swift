//
//  MenuViewModifier.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

struct MenuModifier<T>: ViewModifier where T: CaseIterable & RawRepresentable & Hashable, T.RawValue == String {
    @Binding var isPresented: Bool
    @Binding var selectedItem: T
    var width: CGFloat = 280
    
    var labelFor: (T) -> String = { $0.rawValue }
    var iconFor: (T) -> Image? = { _ in nil }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            MenuView<T>(
                isPresented: $isPresented,
                selectedItem: $selectedItem,
                width: width,
                labelFor: labelFor,
                iconFor: iconFor
            )
        }
    }
}

extension View {
    func menu<T>(
        isPresented: Binding<Bool>,
        selectedItem: Binding<T>,
        width: CGFloat = 250,
        labelFor: @escaping (T) -> String = { $0.rawValue },
        iconFor: @escaping (T) -> Image? = { _ in nil }
    ) -> some View where T: CaseIterable & RawRepresentable & Hashable, T.RawValue == String {
        modifier(MenuModifier(isPresented: isPresented, selectedItem: selectedItem, width: width, labelFor: labelFor, iconFor: iconFor))
    }
}
