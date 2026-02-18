//
//  EventsScreen.swift
//  Columbia City Christian Church
//
//  Created by Brett Chapin on 2026.02.14.
//

import MIECalendarView
import MIENavigationView
import SwiftUI

// MARK: - Event Route

enum EventRoute: Hashable, Identifiable {
    case list
    case detail(EventItem)

    var id: String {
        switch self {
        case .list: return "list"
        case .detail(let event): return "detail-\(event.id)"
        }
    }
}

// MARK: - Events Screen

struct EventsScreen: View {
    let menuAction: () -> Void

    var body: some View {
        MIENavigationView(root: EventRoute.list) { route in
            switch route {
            case .list:
                EventListView(menuAction: menuAction)
            case .detail(let event):
                EventDetailScreen(event: event)
                    .mieNavigationTitle(
                        Text(event.title).themeStyle(.header, fontColor: .textSecondary)
                    )
                    .mieNavigationBarBackground(Color.main)
                    .mieNavigationBackButtonColor(Color.textSecondary)
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

// MARK: - Event List View

private struct EventListView: View {
    let menuAction: () -> Void
    @Environment(MIENavigator<EventRoute>.self) private var nav
    @State private var selectedDate: DateComponents? = Calendar.current.dateComponents([.year, .month, .day], from: .now)
    @State private var sampleEvents: [EventItem] = EventListView.makeSampleEvents()

    // MARK: - Computed Properties

    private var eventsForSelectedDay: [EventItem] {
        guard let sel = selectedDate else { return [] }
        return sampleEvents.filter {
            $0.date.year == sel.year
                && $0.date.month == sel.month
                && $0.date.day == sel.day
        }
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 0) {
            CalendarView(
                selection: $selectedDate,
                events: sampleEvents
            )
            .dayViewStyle(ChurchDayViewStyle())

            Divider()

            ScrollView(.vertical, showsIndicators: false) {
                eventsListView
                    .padding(.top, 16)
            }
        }
        .background(Color.background)
        .mieNavigationTitle(
            Text("Events").themeStyle(.header, fontColor: .textSecondary)
        )
        .mieNavigationLeading {
            MenuButton(action: menuAction)
        }
        .mieNavigationBarBackground(Color.main)
    }

    // MARK: - Subviews

    @ViewBuilder
    private var eventsListView: some View {
        if eventsForSelectedDay.isEmpty {
            VStack(spacing: 8) {
                Text("No Events")
                    .themeStyle(.mediumHeader, fontColor: .red)
                Text("There are no events scheduled for this day.")
                    .themeStyle(.body, fontColor: .red)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 32)
        } else {
            VStack(spacing: 12) {
                ForEach(eventsForSelectedDay) { event in
                    Button {
                        nav.push(.detail(event))
                    } label: {
                        eventRow(event)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private func eventRow(_ event: EventItem) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(event.time)
                    .themeStyle(.body2, fontColor: .main)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.main.opacity(0.5))
            }
            Text(event.title)
                .themeStyle(.mediumHeader)
            Text(event.description)
                .themeStyle(.body, fontColor: .textSecondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.main.opacity(0.08))
        )
    }

    // MARK: - Sample Data

    private static func makeSampleEvents() -> [EventItem] {
        let calendar = Calendar.current
        let today = Date.now
        var events: [EventItem] = []

        if let monthRange = calendar.range(of: .day, in: .month, for: today),
           let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today)) {
            for dayOffset in monthRange {
                if let date = calendar.date(byAdding: .day, value: dayOffset - 1, to: startOfMonth) {
                    let weekday = calendar.component(.weekday, from: date)
                    if weekday == 1 {
                        let eventDate = calendar.date(bySettingHour: 10, minute: 0, second: 0, of: date) ?? date
                        events.append(EventItem(
                            id: UUID(),
                            title: "Worship Service",
                            eventDate: eventDate,
                            time: "10:00 AM",
                            description: "Join us for our weekly worship service."
                        ))
                    } else if weekday == 4 {
                        let eventDate = calendar.date(bySettingHour: 18, minute: 30, second: 0, of: date) ?? date
                        events.append(EventItem(
                            id: UUID(),
                            title: "Bible Study",
                            eventDate: eventDate,
                            time: "6:30 PM",
                            description: "Mid-week Bible study and prayer group."
                        ))
                    }
                }
            }
        }

        if let nextSaturday = calendar.nextDate(
            after: today,
            matching: DateComponents(weekday: 7),
            matchingPolicy: .nextTime
        ) {
            events.append(EventItem(
                id: UUID(),
                title: "Community Potluck",
                eventDate: calendar.date(bySettingHour: 12, minute: 0, second: 0, of: nextSaturday) ?? nextSaturday,
                time: "12:00 PM",
                description: "Bring a dish to share with the community."
            ))
        }

        return events
    }
}

// MARK: - Custom Day View Style

#Preview {
    EventsScreen(menuAction: {})
}
