//
//  TextModifier.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

struct TextModifier: ViewModifier {
    
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    let style: FontStyle
    let lineSpacing: CGFloat
    let fontColor: Color
    
    func body(content: Content) -> some View {
        content
<<<<<<< HEAD
            .font(style.font(size: fontSize))
=======
            .font(style.font())
>>>>>>> 9be296d (Removed fontSize from TextModifier)
            .lineSpacing(lineSpacing)
            .foregroundStyle(fontColor)
            .tracking(style != .body ? 0.5 : 0)
            .contentShape(Rectangle())
    }
    
    private var baseFontSize: CGFloat {
        switch style {
        case .body:
            return 20
        case .body2:
            return 22
        case .mediumHeader:
            return 24
        case .header:
            return 30
        }
    }
    
    private var fontSize: CGFloat {
        switch dynamicTypeSize {
        case .xSmall:
            return baseFontSize * 0.7
        case .small:
            return baseFontSize * 0.8
        case .medium:
            return baseFontSize * 0.9
        case .large:
            return baseFontSize
        case .xLarge:
            return baseFontSize * 1.2
        case .xxLarge:
            return baseFontSize * 1.4
        case .xxxLarge:
            return baseFontSize * 1.6
        case .accessibility1:
            return baseFontSize * 1.8
        default:
            return baseFontSize * 2
        }
    }
}

extension TextModifier {
    enum FontStyle {
        case body
        case body2
        case mediumHeader
        case header
        
        /**
         Generates a `Font` given the value of `self`
         
         - Parameter size: A `CGFloat` that determines the size of a given FontSize
         */
        func font(size: CGFloat) -> Font {
            switch self {
            case .body: return .system(size: size, weight: .regular, design: .default)
            case .body2: return .system(size: size, weight: .regular, design: .default)
            case .mediumHeader: return .system(size: size, weight: .semibold, design: .default)
            case .header: return .system(size: size, weight: .black, design: .default)
            }
        }
    }
}
