import 'package:flutter/material.dart';

/// Controller to manage the state and active index of the AnimatedNotchBottomBar.
class NotchBottomBarController extends ChangeNotifier {
  int _index;

  /// Creates a controller starting at the given [index].
  NotchBottomBarController({int index = 0}) : _index = index;

  /// Returns the current active index.
  int get index => _index;

  /// Jump to a specific index in the bottom bar and notify listeners.
  void jumpTo(int newIndex) {
    if (_index != newIndex) {
      _index = newIndex;
      notifyListeners();
    }
  }
}
