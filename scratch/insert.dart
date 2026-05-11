// ignore_for_file: avoid_print
import 'dart:io';

void main() async {
  final readmeFile = File('README.md');
  if (!await readmeFile.exists()) return;

  String content = await readmeFile.readAsString();

  // 1. Remove all existing instances of the <details> block
  while (content.contains('<details>')) {
    final startIdx = content.indexOf('<details>');
    final endIdx = content.indexOf('</details>') + '</details>'.length;
    if (startIdx != -1 && endIdx != -1) {
       content = content.replaceRange(startIdx, endIdx, '');
    } else {
       break;
    }
  }

  // 2. Add short code to FAQ
  const newFaq = '''**2. Easy to Use:**
Once installed, you can add this beautiful navigation bar to your app with just a few lines of clean, readable code:

```dart
// 1. Import the package
import 'package:bottom_navigation_animated_notch_bar/bottom_navigation_animated_notch_bar.dart';

// 2. Add the widget to your Scaffold
AnimatedNotchBottomBar(
  notchBottomBarController: NotchBottomBarController(index: 0),
  color: Colors.white,
  notchColor: Colors.black87,
  bottomBarItems: const [
    BottomBarItem(
      inActiveItem: Icon(Icons.home_outlined, color: Colors.grey),
      activeItem: Icon(Icons.home_filled, color: Colors.white),
      itemLabel: 'Home',
    ),
    BottomBarItem(
      inActiveItem: Icon(Icons.search_outlined, color: Colors.grey),
      activeItem: Icon(Icons.search, color: Colors.white),
      itemLabel: 'Search',
    ),
  ],
  onTap: (index) {
    // Handle tab change
  },
)
```''';
  content = content.replaceAll('**2. Easy to Use:**\nOnce installed, you can add this beautiful navigation bar to your app with just a few lines of clean, readable code. (See *Key Package Integration* below).', newFaq);


  // 3. Insert the full example block at the very end after the Cross-Platform Support section
  final mainFile = File('example/lib/main.dart');
  if (!await mainFile.exists()) return;
  final mainContent = await mainFile.readAsString();

  final block = '''

## 💻 Full Interactive Example Source Code

The entire example lives in a **single file**: `lib/main.dart`

<details>
<summary><b>✨ Click to Expand Complete main.dart Implementation</b></summary>

```dart
$mainContent
```
</details>
''';

  const targetStr = '## Cross-Platform Support';
  final targetIdx = content.indexOf(targetStr);
  
  if (targetIdx != -1) {
    final before = content.substring(0, targetIdx);
    final after = content.substring(targetIdx);
    content = '$before$block\n\n$after';
  } else {
    content = '$content\n$block';
  }

  // Cleanup any lingering old markers
  content = content.replaceAll('The entire example lives in a **single file**: `lib/main.dart`\n\n##', '##');

  await readmeFile.writeAsString(content);
  print('Successfully restructured README.');
}
