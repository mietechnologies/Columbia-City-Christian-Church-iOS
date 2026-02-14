//
//  MenuItemType.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2026.02.14.
//

import Foundation

protocol MenuItemType: CaseIterable, Hashable {
    var title: String { get }
    var icon: String { get }
}
