//
//  MenuItem.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2025.12.28.
//

import Foundation

enum MenuItem: String, MenuItemType {
    case home = "Home"
    case tithe = "Tithe"
    case directory = "Directory"
    case profile = "Profile"
    case settings = "Settings"
    
    var title: String {
        return self.rawValue
    }
    
    var icon: String {
        switch self {
        case .home:         return "house.fill"
        case .tithe:        return "dollarsign"
        case .directory:    return "person.2.fill"
        case .profile:      return "person.fill"
        case .settings:     return "gearshape.fill"
        }
    }
}
