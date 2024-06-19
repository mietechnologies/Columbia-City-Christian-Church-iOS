//
//  TextModifier.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

struct TextModifier: ViewModifier {
    
    let style: FontStyle
    let lineSpacing: CGFloat
    let fontColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(style.font())
            .lineSpacing(lineSpacing)
            .foregroundColor(fontColor)
            .tracking(style != .body ? 0.5 : 0)
            .padding(.top, 12)
            .contentShape(Rectangle())
    }
}

extension TextModifier {
    enum FontStyle {
        case body
        case mediumHeader
        case header
        
        func font() -> Font {
            switch self {
            case .body: return .body
            case .mediumHeader: return .title3
            case .header: return .title
            }
        }
    }
}
