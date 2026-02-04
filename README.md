# CalMind 🧘

A calming mental health app for daily mood tracking. Built with Flutter.

## Features

- **Daily Mood Check-in**: Log your emotional state with 5 intuitive emojis
- **Optional Notes**: Add context to your mood entries (up to 200 characters)
- **Weekly Mood Trends**: Visualize your emotional patterns with a beautiful line chart
- **History View**: Review all your past check-ins
- **Privacy-First**: All data stored locally on your device
- **Daily Reminders**: Toggle reminders to maintain your wellness routine

## Tech Stack

- **Framework**: Flutter (latest version)
- **Language**: Dart
- **State Management**: Provider
- **Local Database**: sqflite
- **Charts**: fl_chart
- **Date Formatting**: intl

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or later)
- Dart SDK (3.0.0 or later)
- iOS Simulator / Android Emulator or physical device

### Installation

1. Clone the repository or navigate to the project folder:

```bash
cd calmind
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── mood_log.dart         # MoodLog data model
├── providers/
│   ├── mood_provider.dart    # Mood state management
│   └── settings_provider.dart # Settings state management
├── screens/
│   ├── home_screen.dart      # Mood check-in screen
│   ├── history_screen.dart   # History & analytics screen
│   └── settings_screen.dart  # App settings screen
├── services/
│   ├── database_helper.dart  # SQLite database operations
│   └── preferences_service.dart # Shared preferences service
├── theme/
│   └── app_theme.dart        # App theming & colors
└── widgets/
    └── mood_emoji_selector.dart # Mood selection widget
```

## Mood Scale

| Emoji | Value | Meaning |
|-------|-------|---------|
| 😊 | 5 | Happy |
| 😐 | 4 | Neutral |
| 😔 | 3 | Sad |
| 😢 | 2 | Depressed |
| 😤 | 1 | Frustrated |

## Color Palette

- **Primary**: Teal (#26A69A)
- **Background**: Light Mint (#F5F9F8)
- **Surface**: White (#FFFFFF)
- **Text**: Dark Teal (#1C3A36)

## MVP Scope

This is Phase 1 (MVP) of CalMind, focusing on:
- [x] Mood logging with 5-emoji scale
- [x] Optional notes (200 char limit)
- [x] Local SQLite storage
- [x] Weekly mood trend chart
- [x] Check-in history list
- [x] Daily reminder toggle (mock)

## Future Enhancements

- Push notifications for daily reminders
- Export mood data
- Dark mode support
- Mood insights & patterns
- Journaling feature
- Breathing exercises

## License

This project is for educational purposes.

---

Built with 💚 for mental wellness

