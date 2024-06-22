//
//  TextExtensions.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/18/24.
//

import SwiftUI

extension Text {
    /**
     A custom modifier for Text views that applies the `TextModifier` ViewModifier. Which allows for quick and uniform formattering.
     
     - Parameter style: This is the font style for the Text view, this controls font characteristic of the Text view.
     - Parameter lineSpacing: This CGFloat controlls the spacing in points between multiline text. By default this is 1.
     - Parameter fontColor: This represents the color for the Text, by default this is `.textPrimary`.
     */
    func themeStyle(_ style: TextModifier.FontStyle,
                    lineSpacing: CGFloat = 1,
                    fontColor: Color = .textPrimary) -> some View {
        self.modifier(TextModifier(style: style, lineSpacing: lineSpacing, fontColor: fontColor))
    }
}
