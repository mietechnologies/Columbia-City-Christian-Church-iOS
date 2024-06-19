//
//  ScrollingTabModel.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 6/19/24.
//

import SwiftUI

struct ScrollingTabModel: Identifiable {
    private(set) var id: Tab
    
    // TODO: This will need to be updated once a final version has been made
    // The current selection is purely for testing
    enum Tab: String, CaseIterable {
        case dashboard = "Dashboard"
        case checkIn = "Check In"
        case tithe = "Tithe"
        case sermonNotes = "Sermon Notes"
        case prayerChain = "Prayer Chain"
        case events = "Events"
    }
}
