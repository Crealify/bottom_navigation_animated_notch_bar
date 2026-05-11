## 1.1.0
* **Futuristic "Liquid" Spring Physics**: Upgraded default notch sliding animation to a beautiful, bouncy `Curves.easeOutBack` physics curve. Developers can now customize the physics via the `notchAnimationCurve` property.
* **Dynamic Color Morphing (Material You)**: Added `activeColor` support to `BottomBarItem`. The floating icon and glow will now seamlessly and dynamically morph between colors while sliding between tabs.
* **Built-in Smart Haptics**: Added native `HapticFeedback`. The bar provides a light tap when moving and a satisfying "thud" when the notch lands. Configurable via `showHapticFeedback` (pure Dart, no external dependencies).

## 1.0.3
* Updated README.md documentation to clearly outline package installation and benefits.

## 1.0.2
* **Performance Optimization**: Rewrote `NotchPainter` to use a single continuous path, significantly reducing rendering overhead.
* **Repaint Isolation**: Added `RepaintBoundary` to the floating icon to isolate animations from the rest of the UI.
* **Modern SDK Support**: Updated to Flutter 3.24.0 and migrated to the `withValues()` API for colors.
* **Smoother UX**: Replaced static transitions with `AnimatedOpacity` for tab icons and labels.

## 1.0.1

* Updated package logo and demo GIF in README.
* Minor documentation improvements.

## 1.0.0

* Initial release of `bottom_navigation_animated_notch_bar`.
* Fluid animated notch with `easeOutCubic` transition between tabs.
* Floating active icon with breathing glow animation.
* Fully customizable: colors, gradients, notch radius, bar height, labels.
* Optional glassmorphism blur effect (`showBlurBottomBar`).
* Responsive layout — adapts to narrow, tablet, and desktop widths.
* Cross-platform: Android, iOS, Web, Windows, macOS, Linux.
* Pure Dart/Flutter — zero native configuration required.
