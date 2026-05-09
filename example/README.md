<div align="center">

<img src="https://raw.githubusercontent.com/Crealify/bottom_navigation_animated_notch_bar/main/assets/bottom_navigation_animated_notch_bar.png" width="200" alt="Animated Notch Bar Logo">

# bottom_navigation_animated_notch_bar

**A uniquely designed, highly customizable animated notch bottom navigation bar for Flutter.**

[![GitHub](https://img.shields.io/badge/GitHub-Crealify-181717?logo=github)](https://github.com/Crealify/bottom_navigation_animated_notch_bar)
[![pub version](https://img.shields.io/badge/pub-v1.0.0-blue?logo=dart)](https://pub.dev/packages/bottom_navigation_animated_notch_bar)
[![License: BSD-3](https://img.shields.io/badge/License-BSD--3--Clause-blue.svg)](https://github.com/Crealify/bottom_navigation_animated_notch_bar/blob/main/LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Linux%20%7C%20macOS%20%7C%20Windows-green)](#cross-platform-support)

</div>

---

## Live Action: Smooth, Dynamic Navigation

A fluid, modern navigation experience to keep your users engaged.

![Notch Bar Full Demo](https://raw.githubusercontent.com/Crealify/bottom_navigation_animated_notch_bar/main/doc/bottom_navigation_animated_notch_bar.gif)

### Try the Interactive Demo:
* [**Try Android | iOS | Web Demo**](https://htmlpreview.github.io/?https://github.com/Crealify/bottom_navigation_animated_notch_bar/blob/main/doc/demo.html) — See the live animated notch bar across all platforms.

---

## About This Example

This example app (`example/`) is a **complete, production-quality demo** of how to integrate `bottom_navigation_animated_notch_bar` into any Flutter application. It demonstrates:

- Integrating the package with `GetX` state management
- Responsive layout that adapts between mobile (notch bar) and desktop (top nav bar)
- Scroll-to-section navigation using `GlobalKey`
- Animated section reveals with `flutter_animate` and `visibility_detector`
- The `AnimatedNotchBottomBar` widget with all key parameters configured

The entire example lives in a **single file**: `lib/main.dart`

---

## Prerequisites

Before running this example, ensure you have the following installed:

| Tool | Minimum Version | Check Command |
|------|----------------|---------------|
| Flutter SDK | 3.16.0 | `flutter --version` |
| Dart SDK | 3.2.0 | `dart --version` |
| Android Studio / Xcode | Latest | — |
| Chrome (for Web) | Latest | — |

---

## Step-by-Step Setup

### Step 1 — Clone the Repository

```bash
git clone https://github.com/Crealify/bottom_navigation_animated_notch_bar.git
cd bottom_navigation_animated_notch_bar
```

### Step 2 — Get Dependencies for the Example

```bash
cd example
flutter pub get
```

> [!NOTE]
> The example depends on the **local parent package** via `path: ../`. No separate package installation is needed.

### Step 3 — Choose Your Target Platform

---

## 🤖 Running on Android

### Requirements
- Android Studio with Android SDK installed
- A physical Android device (API 21+) **or** an Android Emulator (API 21+)

### Steps

**1. Connect your device or start an emulator:**
```bash
# List available devices
flutter devices

# Example output:
# sdk gphone64 x86 64 • emulator-5554 • android-x64 • Android 14 (API 34)
# My Phone            • ABC123DEF456  • android-arm  • Android 13 (API 33)
```

**2. Run the example on Android:**
```bash
cd example
flutter run -d android
```
Or target a specific device ID:
```bash
flutter run -d emulator-5554
```

**3. What to expect:**
- On a phone screen (width < 850dp), the **Animated Notch Bottom Bar** appears at the bottom
- Tap any tab to see the smooth notch animation slide to the active position
- Scroll down to trigger section-reveal animations
- The bar auto-hides slightly when scrolling down and reappears on scroll up

> [!TIP]
> For best performance on Android, run with `--release` flag: `flutter run --release -d android`

---

## 🍎 Running on iOS

### Requirements
- macOS with Xcode 14+ installed
- An iOS Simulator **or** a physical iPhone/iPad (iOS 12+)
- Apple Developer account (for physical device deployment)

### Steps

**1. Install iOS pods (first time only):**
```bash
cd example/ios
pod install
cd ..
```

**2. List available iOS simulators:**
```bash
flutter devices
# iPhone 15 Pro • 12345678-ABCD-... • ios • com.apple.CoreSimulator...
```

**3. Run on iOS Simulator:**
```bash
cd example
flutter run -d iphone
```
Or open in Xcode for more control:
```bash
open ios/Runner.xcworkspace
```
Then press **▶ Run** in Xcode.

**4. Run on a physical iPhone:**
```bash
# Trust your Mac on the device first, then:
flutter run -d <your-device-id>
```

**5. What to expect on iOS:**
- The notch bar respects iOS Safe Area (bottom home indicator)
- Smooth `easeOutCubic` animation matches iOS's native feel
- The glassmorphic top navigation bar uses `BackdropFilter` for the blur effect

> [!IMPORTANT]
> If you see a signing error, open `ios/Runner.xcworkspace` in Xcode, go to **Signing & Capabilities**, and select your Apple Developer Team.

---

## 🌐 Running on Web

### Requirements
- Google Chrome (recommended) or any modern browser
- No additional setup needed — Flutter Web works out of the box

### Steps

**1. Enable Flutter Web (if not already enabled):**
```bash
flutter config --enable-web
```

**2. Run in Chrome:**
```bash
cd example
flutter run -d chrome
```

**3. Run on a custom port:**
```bash
flutter run -d web-server --web-port 8080
# Then open http://localhost:8080 in any browser
```

**4. Build a production web bundle:**
```bash
flutter build web --release
# Output in: example/build/web/
```
To serve it locally:
```bash
cd build/web
python -m http.server 8080
```

**5. What to expect on Web:**
- On wide screens (≥ 1100px), the **top glassmorphic navigation bar** is shown
- On narrow screens (< 850px), the **Animated Notch Bottom Bar** appears at the bottom
- Resize the browser window to see the responsive switch between layouts
- Mouse hover effects activate on all interactive elements

> [!TIP]
> Use Chrome DevTools → Toggle Device Toolbar (Ctrl+Shift+M) to simulate mobile layouts.

---

## Cross-Platform Support

This package is built with **100% pure Dart and Flutter**. No native configuration required.

| Platform | Notch Bar Visible | Notes |
|----------|:-----------------:|-------|
| ✅ Android | Yes (mobile width) | API 21+ |
| ✅ iOS | Yes (mobile width) | iOS 12+, respects SafeArea |
| ✅ Web | Yes (narrow) / Top Nav (wide) | Responsive breakpoint at 1100px |
| ✅ Windows | Yes (narrow) / Top Nav (wide) | Desktop layout auto-applies |
| ✅ macOS | Yes (narrow) / Top Nav (wide) | Desktop layout auto-applies |
| ✅ Linux | Yes (narrow) / Top Nav (wide) | Desktop layout auto-applies |

---

## Key Package Integration

The core of this example is in `lib/main.dart`. Here is the essential widget usage:

```dart
// 1. Import the package
import 'package:bottom_navigation_animated_notch_bar/bottom_navigation_animated_notch_bar.dart';

// 2. Create a controller (manages active index)
final controller = NotchBottomBarController(index: 0);

// 3. Add the widget
AnimatedNotchBottomBar(
  notchBottomBarController: controller,
  color: const Color(0xFF2A2D3E),        // Bar background color
  notchColor: const Color(0xFF151521),    // Circle/notch dark background
  activeIconColor: const Color(0xFF00E5FF), // Glowing active icon color
  showLabel: true,
  removeMargins: true,
  bottomBarHeight: 72.0,
  bottomBarItems: const [
    BottomBarItem(
      inActiveItem: Icon(Icons.home_outlined, color: Colors.white60),
      activeItem: Icon(Icons.home_filled),
      itemLabel: 'Home',
    ),
    BottomBarItem(
      inActiveItem: Icon(Icons.search_outlined, color: Colors.white60),
      activeItem: Icon(Icons.search),
      itemLabel: 'Search',
    ),
    // ... up to 5 items
  ],
  onTap: (index) {
    controller.jumpTo(index);
    // Navigate to the selected section
  },
),
```

---

## `pubspec.yaml` for This Example

```yaml
name: example
description: "Demonstrates how to use the bottom_navigation_animated_notch_bar plugin."
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.2.0
  flutter: ">=3.16.0"

dependencies:
  flutter:
    sdk: flutter
  bottom_navigation_animated_notch_bar:
    path: ../          # Points to the local package
  get: ^4.6.6
  url_launcher: ^6.2.1
  flutter_animate: ^4.2.0+1
  visibility_detector: ^0.4.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
```

---

## Troubleshooting

### `flutter pub get` fails
```bash
flutter clean && flutter pub get
```

### iOS Pod install fails
```bash
cd ios && pod deintegrate && pod install
```

### Web build fails with JS errors
```bash
flutter build web --release --dart2js-optimization=O4
```

### `flutter run` shows "No devices found"
```bash
# Check connected devices
flutter doctor
flutter devices
```

---

## Resources

- 📦 [Package on pub.dev](https://pub.dev/packages/bottom_navigation_animated_notch_bar)
- 💻 [Source Code on GitHub](https://github.com/Crealify/bottom_navigation_animated_notch_bar)
- 📄 [Full API Documentation](https://pub.dev/documentation/bottom_navigation_animated_notch_bar/latest/)
- 🐛 [Report an Issue](https://github.com/Crealify/bottom_navigation_animated_notch_bar/issues)
- 🌐 [Live HTML Demo](https://htmlpreview.github.io/?https://github.com/Crealify/bottom_navigation_animated_notch_bar/blob/main/doc/demo.html)

---

<div align="center">
Made with ❤️ by <a href="https://github.com/Crealify">Crealify</a> · BSD-3-Clause License
</div>
