# Online Trading Learning Platform

A cross-platform Flutter application for learning online trading. The app provides video-based courses, quizzes, assignments, community features, AI-powered analysis, marketplace and payment flows. Target platforms: Android, iOS and Web.

---

## Table of Contents

- About
- Key Features
- Screenshots
- Tech Stack
- Getting Started
- Configuration
- Project Structure
- Testing
- Contributing
- License

---

## About

This repository contains a production-oriented Flutter app that delivers a complete learning experience for traders. It organizes code by feature modules and aims for maintainability and extensibility.

## Key Features

- Course catalog and structured course content (video lessons, documents)
- Video player integration and splash video
- Quizzes, assignments and progress tracking
- User authentication and profile management
- Community features (discussions, feeds)
- AI analysis tools for insights (see `lib/features/ai_analysis`)
- Marketplace for digital resources and in-app purchases
- Payments and invoice/webview handling
- Notifications, calendar scheduling, and search
- Theming, responsive UI and reusable widgets

## Screenshots

Preview images and icons are available in the `assets/` and `images/` folders. Use these during UI review and documentation.

## Tech Stack

- Flutter (Dart) — single codebase for Android, iOS and Web
- Native project files under `android/` and `ios/`
- Modular feature structure under `lib/features/`

## Getting Started

Prerequisites
- Flutter SDK (compatible version declared in `pubspec.yaml`)
- Android SDK / Xcode for device builds

Local setup

1. Clone the repository
   git clone <repo-url>
2. Change to project directory
   cd "Online Trading Learning Platform"
3. Install Dart/Flutter packages
   flutter pub get
4. Run the app
   flutter run -d <device-id>
   or for web: `flutter run -d chrome`

Release builds
- Android: `flutter build apk` or `flutter build appbundle`
- iOS: `flutter build ios` (requires Xcode and code signing)
- Web: `flutter build web`

## Configuration

- Check `lib/core/init` and `lib/core/di` for app initialization and dependency injection.
- Add API keys and production credentials to your build-time config or platform-specific config files (do not commit secrets).
- Payment, notification and AI features may require external keys and backend endpoints.

## Project Structure (high level)

- `lib/` — main source, organized by features and core modules
- `assets/`, `images/`, `video/` — static media
- `android/`, `ios/`, `web/` — platform projects
- `test/` — unit and widget tests

## Testing

Run all tests:

flutter test

## Contributing

Contributions are welcome. Please:
1. Open an issue to discuss major changes
2. Create a branch for your change
3. Submit a pull request with a clear description and tests when applicable

## License

This repository does not include a license file yet. Add a LICENSE (for example MIT) to clarify usage and distribution.

---

If you want, I can add a badges section, examples of environment variables, or a CONTRIBUTING.md and CODE_OF_CONDUCT file.
