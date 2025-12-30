//
//  PageNavigator.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import SwiftUI

@Observable
final class PageNavigator<Route: Identifiable & Hashable>: ObservableObject {
    var stack: [Route]
    var visibleID: Route.ID?

    init(root: Route) {
        self.stack = [root]
        self.visibleID = root.id
    }

    func push(_ route: Route, animated: Bool = true) {
        if animated {
            withAnimation(.snappy) {
                stack.append(route)
                visibleID = route.id
            }
        } else {
            stack.append(route)
            visibleID = route.id
        }
    }

    @discardableResult
    func pop(animated: Bool = true) -> Route? {
        guard stack.count > 1 else { return nil }
        let newLast = stack[stack.count - 2]
        if animated {
            withAnimation(.snappy) {
                _ = stack.removeLast()
                visibleID = newLast.id
            }
        } else {
            _ = stack.removeLast()
            visibleID = newLast.id
        }
        return newLast
    }

    func popToRoot(animated: Bool = true) {
        guard stack.count > 1 else { return }
        let root = stack.first!
        if animated {
            withAnimation(.snappy) {
                stack.removeSubrange(1..<stack.endIndex)
                visibleID = root.id
            }
        } else {
            stack.removeSubrange(1..<stack.endIndex)
            visibleID = root.id
        }
    }
}
