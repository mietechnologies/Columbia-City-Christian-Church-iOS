//
//  RoundedRectangleButtonStyle.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/21/24.
//

import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
    
    let type: ButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer(minLength: 0)
            
            configuration.label
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 10)
            .foregroundStyle(type.foregroundColor)
            .background(type.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(color: .black.opacity(0.6), radius: 4, x: 3, y: 3)
    }
}

extension RoundedRectangleButtonStyle {
    enum ButtonType {
        case neutral
        case destructive
        case confirmation
        
        var backgroundColor: Color {
            switch self {
            case .neutral:      .blue
            case .destructive:  .destructiveButtonBackground
            case .confirmation: .green
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .neutral:      Color.white
            case .destructive:  Color.red
            case .confirmation: Color.white
            }
        }
    }
}
