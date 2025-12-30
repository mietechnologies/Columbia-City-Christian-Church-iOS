//
//  SafeAreaInsetsKey.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        #if os(iOS) || os(tvOS)
        return (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
        #else
        return .zero
        #endif
        
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets { self[SafeAreaInsetsKey.self] }
}

private extension UIEdgeInsets {
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
