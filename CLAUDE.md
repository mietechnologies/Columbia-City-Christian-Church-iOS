# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Columbia City Christian Church is a native iOS SwiftUI application for a church community. The app provides features for church information, tithing, member directory, and user profiles.

## Build Commands

### Building the Project
```bash
cd "/Volumes/Extreme Pro/Projects/Programming/Swift/Apps/Columbia City Christian Church"
xcodebuild -project "Columbia City Christian Church.xcodeproj" \
  -scheme "Columbia City Christian Church" \
  -sdk iphonesimulator \
  build
```

### Running Tests
```bash
# Run all tests
xcodebuild test \
  -project "Columbia City Christian Church.xcodeproj" \
  -scheme "Columbia City Christian Church" \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro'

# Run specific test target
xcodebuild test \
  -project "Columbia City Christian Church.xcodeproj" \
  -scheme "Columbia City Christian Church" \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  -only-testing:"Columbia City Christian ChurchTests/AppTests"
```

### Linting
```bash
# Run SwiftLint via fastlane
fastlane lint

# Run SwiftLint directly
swiftlint lint --config .swiftlint.yml
```

## Architecture

### Navigation System

The app uses a custom navigation pattern with two key components:

1. **MenuView with ViewModifier Pattern**: A generic slide-out menu system implemented as a ViewModifier
   - `MenuView<T>`: Generic menu component that works with any `CaseIterable & RawRepresentable & Hashable` enum
   - `MenuModifier<T>`: ViewModifier that overlays the menu on any view
   - `.menu(isPresented:selectedItem:)` extension on View for easy integration
   - Menu items are defined in `MenuItem` enum (home, tithe, directory, profile, settings)

2. **PageNavigationView**: Custom horizontal page-based navigation with swipe gestures
   - Uses `PageNavigator<Route>` as an `@Observable` object to manage navigation stack
   - Built on top of SwiftUI's `ScrollView` with paging behavior
   - Supports push/pop navigation with animations
   - Edge swipe gesture (from left edge) triggers back navigation
   - Routes must conform to `Identifiable & Hashable`

### Theming System

Custom theming built on ViewModifiers:

- **TextModifier**: Provides consistent typography with automatic dynamic type scaling
  - Font styles: `.body`, `.body2`, `.mediumHeader`, `.header`
  - Respects system dynamic type sizes with custom scaling factors
  - Usage: `.themeStyle(.mediumHeader, lineSpacing: 1, fontColor: .textPrimary)`

- **Color System**: Defined in Assets.xcassets with semantic naming
  - `MainColor`, `TertiaryColor`, `SecondaryAccent`
  - `TextPrimary`, `TextSecondary`
  - `Background`
  - Access via `Color.main`, `Color.tertiary`, etc.

### Custom Environment Keys

- **SafeAreaInsetsKey**: Provides safe area insets via environment values
  - Access: `@Environment(\.safeAreaInsets) private var safeAreaInsets`
  - Platform-aware (iOS/tvOS vs other platforms)

### Project Structure

```
Columbia City Christian Church/
├── ColumbiaCityChristianChurchApp.swift  # App entry point
├── ContentView.swift                      # Root view with menu integration
├── Models/
│   ├── MenuItem.swift                     # Main menu items enum
│   └── ContactInfo.swift                  # Contact information model
├── Views/
│   ├── Components/
│   │   ├── MenuView.swift                 # Generic slide-out menu
│   │   ├── HeaderView.swift               # App header component
│   │   ├── ContactInfoView.swift          # Contact info display
│   │   └── LocationMapView.swift          # Map integration
│   ├── PageNavigationView/
│   │   ├── PageNavigationView.swift       # Horizontal page navigation
│   │   └── PageNavigator.swift            # Navigation state manager
│   ├── AboutChurchScreen.swift            # Church info screen
│   └── TestView.swift                     # Test/placeholder screen
├── ViewModifiers/
│   ├── TextModifier.swift                 # Typography theming
│   └── MenuViewModifier.swift             # Menu integration modifier
├── EnvironmentKeys/
│   └── SafeAreaInsetsKey.swift            # Safe area environment key
└── Extensions/
    └── OptionalExtension.swift            # Optional utilities
```

## Code Style Guidelines

### SwiftLint Configuration

The project uses SwiftLint with custom rules (`.swiftlint.yml`):

- **Line length**: 120 warning, 200 error
- **Function body length**: 40 warning, 75 error
- **Type body length**: 300 warning, 500 error
- **File length**: 500 warning, 1200 error
- **Custom rule**: Force unwrapping (`!`) triggers an error - use optional binding instead

### Key Disabled Rules
The following rules are intentionally disabled:
- `trailing_whitespace`, `colon`, `comma`, `control_statement`
- `cyclomatic_complexity`, `large_tuple`
- `todo` (TODO comments are allowed)

### Generic Type Constraints

When working with generic types in SwiftUI:
- **IMPORTANT**: Static stored properties are not supported in generic types
- Move constants outside the generic struct/class (e.g., create a separate enum for constants)
- Example: `MenuViewLayout` enum is defined outside `MenuView<T>` to hold layout constants

### View Organization

When creating complex views:
1. Extract subviews as computed properties or methods for readability
2. Use `@ViewBuilder` for conditional views
3. Group related constants in a dedicated enum (placed outside generic types)
4. Use MARK comments to organize: `// MARK: - Subviews`, `// MARK: - Computed Properties`

### Generic Menu Integration

To integrate MenuView with a custom enum:
```swift
enum YourMenuItems: String, CaseIterable, Hashable {
    case item1 = "Item 1"
    case item2 = "Item 2"
}

struct YourView: View {
    @State private var showMenu = false
    @State private var selection: YourMenuItems = .item1

    var body: some View {
        YourContent()
            .menu(
                isPresented: $showMenu,
                selectedItem: $selection,
                width: 280,
                labelFor: { $0.rawValue },
                iconFor: { item in /* return optional Image */ }
            )
    }
}
```

### Page Navigation Integration

To use PageNavigationView:
```swift
enum YourRoute: Hashable, Identifiable {
    case screen1
    case screen2(id: String)

    var id: String {
        switch self {
        case .screen1: return "screen1"
        case .screen2(let id): return "screen2-\(id)"
        }
    }
}

PageNavigationView(route: YourRoute.screen1) { route in
    switch route {
    case .screen1:
        Screen1View()
    case .screen2(let id):
        Screen2View(id: id)
    }
}
```

Access the navigator in child views:
```swift
@Environment(PageNavigator<YourRoute>.self) private var nav

// Push new route
nav.push(.screen2(id: "123"))

// Pop back
nav.pop()

// Pop to root
nav.popToRoot()
```

## Testing

Test targets:
- `Columbia City Christian ChurchTests`: Unit tests
- `Columbia City Christian ChurchUITests`: UI tests
