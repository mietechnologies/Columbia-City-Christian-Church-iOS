//
//  TextExtensions.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

extension Text {
    func themeStyle(_ style: TextModifier.FontStyle, 
                    lineSpacing: CGFloat = 1,
                    fontColor: Color = .textPrimary,
                    fontSize: CGFloat? = nil) -> some View {
        self.modifier(TextModifier(style: style, lineSpacing: lineSpacing, fontColor: fontColor, fontSize: fontSize))
    }
}
