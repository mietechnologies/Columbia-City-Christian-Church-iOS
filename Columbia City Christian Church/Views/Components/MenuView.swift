//
//  MenuView.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

// MARK: - Layout Constants
private enum MenuViewLayout {
    static let logoSize: CGFloat = 75
    static let iconSpacing: CGFloat = 12
    static let shadowRadius: CGFloat = 12
    static let profileIconSize: CGFloat = 30
    static let profileIconPadding: CGFloat = 10
    static let signInSectionHeight: CGFloat = 75
    static let animationDuration: Double = 0.2
}

struct MenuView<T>: View where T: RawRepresentable & MenuItemType, T.RawValue == String {
    @Binding var isPresented: Bool
    @Binding var selectedItem: T
    var edge: Edge = .leading
    var width: CGFloat = 280

    @Environment(\.safeAreaInsets) private var safeAreaInsets

    private var alignment: Alignment {
        edge == .leading ? .leading : .trailing
    }

    private var menuItems: [T] {
        Array(T.allCases)
    }
    
    var body: some View {
        ZStack(alignment: alignment) {
            backdrop
            menuPanel
        }
        .animation(.easeIn(duration: MenuViewLayout.animationDuration), value: isPresented)
    }

    // MARK: - Subviews
    @ViewBuilder
    private var backdrop: some View {
        if isPresented {
            Rectangle()
                .fill(.thinMaterial)
                .ignoresSafeArea()
                .transition(.opacity)
                .onTapGesture {
                    withAnimation { isPresented = false }
                }
                .accessibilityHidden(true)
        }
    }

    private var menuPanel: some View {
        VStack(spacing: 0) {
            headerSection
            
            ScrollView {
                menuItemsList
            }

            Spacer(minLength: 0)

            signInSection
        }
        .padding(.top, safeAreaInsets.top)
        .padding(.bottom, safeAreaInsets.bottom)
        .frame(width: width)
        .background(Color.tertiary)
        .ignoresSafeArea()
        .shadow(radius: MenuViewLayout.shadowRadius)
        .offset(x: panelOffsetX)
        .transition(.move(edge: edge))
        .accessibilityElement(children: .contain)
    }

    private var headerSection: some View {
        VStack(spacing: 5) {
            Image("ChurchLogo")
                .resizable()
                .scaledToFit()
                .frame(width: MenuViewLayout.logoSize, height: MenuViewLayout.logoSize)

            Text("Columbia City")
                .themeStyle(.body, fontColor: .textSecondary)
                .fontWeight(.semibold)

            Text("Christian Church")
                .themeStyle(.body2, fontColor: .textSecondary)
                .fontWeight(.bold)
        }
        .padding(.bottom, 10)
    }

    private var menuItemsList: some View {
        ForEach(menuItems, id: \.self) { item in
            menuItemButton(for: item)
        }
    }

    private func menuItemButton(for item: T) -> some View {
        Button {
            selectedItem = item
            withAnimation { isPresented = false }
        } label: {
            VStack {
                Spacer()
                
                HStack(spacing: MenuViewLayout.iconSpacing) {
                    Image(systemName: item.icon)
                        .frame(width: 24)
                        .foregroundStyle(.white)
                        .padding(.leading, 10)
                    
                    Text(item.title)
                        .themeStyle(.menuItem, fontColor: .textSecondary)
                        .fontWeight(.regular)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.white)
                        .padding(.trailing, 10)
                }
                
                Spacer()
                
                if (selectedItem != item) && (menuItems.last != item) {
                    Divider()
                        .overlay(Color.white)
                        .padding(.horizontal)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 8.0)
                    .fill(selectedItem == item ? Color.white.opacity(0.1) : Color.clear)
                    .stroke(selectedItem == item ? Color.white.opacity(0.2) : Color.clear, lineWidth: 0.5)
            )
            .padding(.horizontal, 10)
        }
        .frame(height: 50)
    }

    private var signInSection: some View {
        HStack(spacing: 10) {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: MenuViewLayout.profileIconSize, height: MenuViewLayout.profileIconSize)
                .padding(MenuViewLayout.profileIconPadding)
                .background(Color.white)
                .clipShape(Circle())

            Text("Sign In")
                .themeStyle(.body2, fontColor: .textSecondary)
                .fontWeight(.semibold)

            Spacer()
        }
        .padding(.horizontal)
        .frame(height: MenuViewLayout.signInSectionHeight)
        .background(Color.main)
    }

    // MARK: - Computed Properties
    private var panelOffsetX: CGFloat {
        guard !isPresented else { return 0 }
        return edge == .leading ? -(width + MenuViewLayout.logoSize) : width
    }
    
}

#Preview {
    MenuView<MenuItem>(isPresented: .constant(true), selectedItem: .constant(.home))
}
