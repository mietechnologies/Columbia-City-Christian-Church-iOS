//
//  EventDetailScreen.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2026.02.16.
//

import SwiftUI

struct EventDetailScreen: View {
    let event: EventItem

    // MARK: - Computed Properties

    private var formattedDate: String {
        event.eventDate.formatted(date: .long, time: .omitted)
    }

    // MARK: - Body

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text(event.title)
                    .themeStyle(.header, fontColor: .main)

                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .foregroundStyle(Color.textSecondary)
                        Text(formattedDate)
                            .themeStyle(.body2, fontColor: .textSecondary)
                    }
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .foregroundStyle(Color.textSecondary)
                        Text(event.time)
                            .themeStyle(.body2, fontColor: .textSecondary)
                    }
                }

                Divider()

                Text(event.description)
                    .themeStyle(.body, lineSpacing: 3)
            }
            .padding()
        }
        .background(Color.background)
    }
}
