import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'bottom_bar_item.dart';
import 'notch_bottom_bar_controller.dart';
import 'notch_painter.dart';

/// A custom, animated, notch bottom navigation bar widget.
class AnimatedNotchBottomBar extends StatefulWidget {
  final NotchBottomBarController notchBottomBarController;
  final List<BottomBarItem> bottomBarItems;
  final Function(int) onTap;
  final Color color;
  final bool removeMargins;
  final double? bottomBarWidth;
  final double bottomBarHeight;
  final int durationInMilliSeconds;
  final bool showLabel;
  final TextStyle? itemLabelStyle;
  final bool showShadow;
  final bool showBlurBottomBar;
  final double blurOpacity;
  final double blurFilterX;
  final double blurFilterY;
  final Color notchColor;
  final Gradient? notchGradient;
  final bool showTopRadius;
  final bool showBottomRadius;
  final double elevation;
  final Color activeIconColor;

  const AnimatedNotchBottomBar({
    super.key,
    required this.notchBottomBarController,
    required this.bottomBarItems,
    required this.onTap,
    this.color = Colors.white,
    this.removeMargins = false,
    this.bottomBarWidth,
    this.bottomBarHeight = 75.0,
    this.durationInMilliSeconds = 300,
    this.showLabel = true,
    this.itemLabelStyle,
    this.showShadow = true,
    this.showBlurBottomBar = false,
    this.blurOpacity = 0.5,
    this.blurFilterX = 5.0,
    this.blurFilterY = 10.0,
    this.notchColor = Colors.white,
    this.notchGradient,
    this.showTopRadius = true,
    this.showBottomRadius = true,
    this.elevation = 5.0,
    this.activeIconColor = const Color(0xFF00E5FF),
  }) : assert(bottomBarItems.length > 1 && bottomBarItems.length < 6);

  @override
  State<AnimatedNotchBottomBar> createState() => _AnimatedNotchBottomBarState();
}

class _AnimatedNotchBottomBarState extends State<AnimatedNotchBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.notchBottomBarController.index;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationInMilliSeconds),
    );
    _animation = Tween<double>(
      begin: _currentIndex.toDouble(),
      end: _currentIndex.toDouble(),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    widget.notchBottomBarController.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (widget.notchBottomBarController.index != _currentIndex) {
      _moveNotch(widget.notchBottomBarController.index);
    }
  }

  void _moveNotch(int index) {
    _animation = _animationController.drive(
      Tween<double>(begin: _animation.value, end: index.toDouble())
          .chain(CurveTween(curve: Curves.easeOutCubic)),
    );
    _animationController.forward(from: 0.0);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    widget.notchBottomBarController.removeListener(_onControllerChanged);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = widget.bottomBarWidth ?? constraints.maxWidth;
        final bool isNarrow = width < 350;
        final bool isUltraNarrow = width < 280;
        final bool isExtremeNarrow = width < 180;

        final double margin = widget.removeMargins
            ? 0
            : (isExtremeNarrow ? 4.0 : (isNarrow ? 10.0 : 20.0));
        final double barWidth = width - (margin * 2);
        final double itemWidth = barWidth / widget.bottomBarItems.length;

        final double notchRadius =
            isExtremeNarrow ? 20.0 : (isNarrow ? 26.0 : 34.0);
        final double circleRadius =
            isExtremeNarrow ? 14.0 : (isNarrow ? 22.0 : 28.0);
        final double notchSize = circleRadius * 2;
        final double floatingIconSize =
            isExtremeNarrow ? 16.0 : (isNarrow ? 20.0 : 24.0);

        return Container(
          width: width,
          margin: EdgeInsets.only(
            left: margin,
            right: margin,
            bottom: widget.removeMargins
                ? 0
                : (10.0 + MediaQuery.of(context).padding.bottom),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  return CustomPaint(
                    size: Size(barWidth, widget.bottomBarHeight),
                    painter: NotchPainter(
                      notchRadius: notchRadius,
                      notchPosition:
                          (_animation.value * itemWidth) + (itemWidth / 2),
                      color: widget.color,
                      showTopRadius: widget.showTopRadius,
                      showBottomRadius: widget.showBottomRadius,
                      elevation: widget.showShadow ? widget.elevation : 0,
                    ),
                    child: widget.showBlurBottomBar
                        ? ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(
                                  widget.showTopRadius ? 20 : 0),
                              bottom: Radius.circular(
                                  widget.showBottomRadius ? 20 : 0),
                            ),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: widget.blurFilterX,
                                sigmaY: widget.blurFilterY,
                              ),
                              child: Container(
                                color: widget.color
                                    .withValues(alpha: widget.blurOpacity),
                                height: widget.bottomBarHeight,
                              ),
                            ),
                          )
                        : SizedBox(
                            child: Container(
                              height: widget.bottomBarHeight,
                              width: barWidth,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.05),
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  );
                },
              ),

              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    left: (_animation.value * itemWidth) +
                        (itemWidth / 2) -
                        circleRadius,
                    top: isExtremeNarrow ? -12 : (isNarrow ? -18 : -25),
                    child: const SizedBox().animate(
                      key: ValueKey('active_icon_$_currentIndex'),
                      onPlay: (controller) => controller.repeat(reverse: true),
                    ).custom(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      builder: (context, value, _) {
                        final animatedColor = Color.lerp(
                            widget.activeIconColor, Colors.white, value)!;
                        return Container(
                          width: notchSize,
                          height: notchSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.notchColor,
                            border: Border.all(
                              color: animatedColor.withValues(alpha: 0.8),
                              width: 2,
                            ),
                            boxShadow: [
                              if (widget.showShadow)
                                BoxShadow(
                                  color: animatedColor.withValues(alpha: 0.4),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                            ],
                          ),
                          child: Center(
                            child: Transform.scale(
                              scale: 1.0 + (value * 0.1),
                              child: IconTheme(
                                data: IconThemeData(
                                  size: floatingIconSize,
                                  color: animatedColor,
                                ),
                                child: widget.bottomBarItems[_currentIndex]
                                    .activeItem,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              SizedBox(
                height: widget.bottomBarHeight,
                child: Row(
                  children:
                      List.generate(widget.bottomBarItems.length, (index) {
                    final item = widget.bottomBarItems[index];
                    final bool isActive = index == _currentIndex;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          widget.onTap(index);
                          widget.notchBottomBarController.jumpTo(index);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Opacity(
                                    opacity: isActive ? 0 : 1,
                                    child: IconTheme(
                                      data: IconThemeData(
                                          size: isExtremeNarrow
                                              ? 16
                                              : (isNarrow ? 20 : 24)),
                                      child: item.inActiveItem,
                                    ),
                                  ),
                                  if (widget.showLabel &&
                                      item.itemLabel != null &&
                                      !isUltraNarrow)
                                    Opacity(
                                      opacity: isActive ? 0 : 1,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          item.itemLabel!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: widget.itemLabelStyle ??
                                              const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11,
                                              ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
