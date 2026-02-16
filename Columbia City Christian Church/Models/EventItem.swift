//
//  EventItem.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2026.02.14.
//

import Foundation
import MIECalendarView

struct EventItem: Identifiable, Hashable, DayEventType {
    let id: UUID
    let title: String
    let eventDate: Date
    let time: String
    let description: String

    var date: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day], from: eventDate)
    }
}
