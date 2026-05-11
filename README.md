<div align="center">

<img src="https://raw.githubusercontent.com/Crealify/bottom_navigation_animated_notch_bar/refs/heads/Crealify/assets/bottom_navigation_animated_notch_bar.png" width="200" alt="Animated Notch Bar Logo">

# bottom_navigation_animated_notch_bar

**A uniquely designed, highly customizable animated notch bottom navigation bar for Flutter.**

[![GitHub](https://img.shields.io/badge/GitHub-Crealify-181717?logo=github)](https://github.com/Crealify/bottom_navigation_animated_notch_bar)
[![pub version](https://img.shields.io/badge/pub-v1.0.3-blue?logo=dart)](https://pub.dev/packages/bottom_navigation_animated_notch_bar)
[![License: BSD-3](https://img.shields.io/badge/License-BSD--3--Clause-blue.svg)](https://github.com/Crealify/bottom_navigation_animated_notch_bar/blob/main/LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Linux%20%7C%20macOS%20%7C%20Windows-green)](#cross-platform-support)

</div>

---

## Live Action: Smooth, Dynamic Navigation

A fluid, modern navigation experience to keep your users engaged.

![Notch Bar Full Demo](https://raw.githubusercontent.com/Crealify/bottom_navigation_animated_notch_bar/refs/heads/Crealify/doc/bottom_navigation_animated_notch_bar.gif)

### Try the Interactive Demo:
* [**Try Android | iOS | Web Demo**](https://htmlpreview.github.io/?https://github.com/Crealify/bottom_navigation_animated_notch_bar/blob/Crealify/doc/demo.html) — See the live animated notch bar across all platforms.

---

## 🤔 FAQ: Why install this instead of just copy-pasting the code?

<details>
<summary><b>✨ Tap here to see why using the package is 10x better! (And view the short code)</b></summary>

Here is a step-by-step breakdown of why developers install packages instead of copying code, and how you benefit from this tool.

### 1. Code Cleanliness (The "Short Code" Benefit)
This is the biggest immediate benefit for you as a developer.

If you copy the source code, you have to put all **300+ lines** of `AnimatedNotchBottomBar`, `NotchPainter`, and `NotchBottomBarController` into your own app's files. It clutters your project.

By installing this package, all the complex animation logic, math, and custom painters are hidden away. After installing, you only need to write this tiny piece of clean code to use it:

```dart
// 1. Just import the package
import 'package:bottom_navigation_animated_notch_bar/bottom_navigation_animated_notch_bar.dart';

// 2. And use this short, clean widget in your UI!
AnimatedNotchBottomBar(
  notchBottomBarController: _controller,
  bottomBarItems: const [
    BottomBarItem(inActiveItem: Icon(Icons.home), activeItem: Icon(Icons.home_filled)),
    BottomBarItem(inActiveItem: Icon(Icons.search), activeItem: Icon(Icons.search)),
  ],
  onTap: (index) => _controller.jumpTo(index),
)
```
That's it! You get a beautiful, complex, animated navigation bar using just 10 lines of code. We did all the hard work so you don't have to.

### 2. Automatic Updates and Bug Fixes
Imagine copying and pasting the source code into your app today. Next week, we discover a bug in the animation, or add a cool new feature, and update this pub.dev package.

*   **If you copy-pasted:** Your app still has the bug. To fix it, you have to come back to this GitHub, find exactly which lines changed, and carefully copy-paste the new code without breaking your app.
*   **If you installed the package:** All you do is run `flutter pub upgrade`. The package manager automatically downloads the newest code, fixes the bug instantly, and you don't have to change a single line of your own code!

### 3. Managing Dependencies Seamlessly
This package uses `flutter_animate` to make the active icon breathe. If you just copy-paste the Dart files, your code will immediately show a red error because you don't have `flutter_animate` installed. You would have to figure out what dependencies we used and install them manually.

When you install this package via `pubspec.yaml`, Flutter **automatically** detects that it needs `flutter_animate` and installs it for you behind the scenes.

### 4. Version Stability
When building big apps, you need stability. By installing this package (e.g., `version: ^1.0.3`), you lock in a version you know works perfectly. A package acts as a "black box" to you, keeping it safe from accidental edits that might break complex Bézier curves or rendering logic.
</details>

---

## 🚀 Package Installation

### 1. Add Dependency
Add the package to your `pubspec.yaml` file:
```yaml
dependencies:
  bottom_navigation_animated_notch_bar: ^1.0.3
```
*Or use the terminal command:*
```bash
flutter pub add bottom_navigation_animated_notch_bar
```

### 2. Import the Package
```dart
import 'package:bottom_navigation_animated_notch_bar/bottom_navigation_animated_notch_bar.dart';
```

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
