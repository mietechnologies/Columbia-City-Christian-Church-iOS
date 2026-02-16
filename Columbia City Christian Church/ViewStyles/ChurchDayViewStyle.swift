//
//  ChurchDayViewStyle.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2026.02.14.
//

import MIECalendarView
import SwiftUI

struct ChurchDayViewStyle: DayViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        let isSelected = configuration.isSelected
        let isToday = configuration.isToday

        VStack(spacing: 1) {
            configuration.label
                .font(isSelected || isToday ? .body.bold() : .body)
                .foregroundStyle(
                    isSelected ? Color.white :
                    isToday ? Color.main : .primary
                )
                .frame(maxWidth: .infinity, minHeight: 32)
                .background {
                    if isSelected {
                        Circle()
                            .fill(Color.main)
                    } else if isToday {
                        Circle()
                            .stroke(Color.main, lineWidth: 1.5)
                    }
                }

            if configuration.eventCount > 0 {
                Circle()
                    .fill(isSelected ? Color.main : Color.main.opacity(0.6))
                    .frame(width: 5, height: 5)
            }
        }
    }
}
