import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

// Import our new professional package
import 'package:bottom_navigation_animated_notch_bar/bottom_navigation_animated_notch_bar.dart';

// =============================================================================
// 1. MAIN ENTRY POINT
// =============================================================================
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notch Bar Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppConstants.bgColor,
        primaryColor: AppConstants.primaryColor,
        colorScheme: const ColorScheme.dark(primary: AppConstants.primaryColor),
      ),
      home: const MainViewWrapper(),
    );
  }
}

// =============================================================================
// 2. CONSTANTS & CONTROLLERS
// =============================================================================
class AppConstants {
  static const Color bgColor = Color(0xFF1A1A29);
  static const Color cardColor = Color(0xFF2A2D3E);
  static const Color darkColor = Color(0xFF151521);
  static const Color primaryColor = Color(0xFF00E5FF);
  static const Color secondaryColor = Color(0xFFFF4D8D);
  static const Color activeIconColor = Color(0xFF00E5FF);
  static const double spacing24 = 24.0;
  static const double spacing64 = 64.0;
}

class AppController extends GetxController {
  final scrollController = ScrollController();
  // Using the controller from the package
  final notchBottomBarController = NotchBottomBarController(index: 0);
  
  final isMenuOpen = false.obs;
  final isNavbarVisible = true.obs;
  final isHeaderVisible = true.obs;

  static final section1Key = GlobalKey();
  static final section2Key = GlobalKey();
  static final section3Key = GlobalKey();
  static final section4Key = GlobalKey();
  static final section5Key = GlobalKey();

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(key.currentContext!, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }
}

final appController = Get.put(AppController());
final globalScrollController = appController.scrollController;

class PortfolioController extends GetxController {
  void trackAction(String action) {
    debugPrint("Tracked action: $action");
  }
}

// =============================================================================
// 3. RESPONSIVE UTILS
// =============================================================================
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({super.key, required this.mobile, this.tablet, required this.desktop});

  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 850;
  static bool isTablet(BuildContext context) => MediaQuery.sizeOf(context).width >= 850 && MediaQuery.sizeOf(context).width < 1100;
  static bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= 1100;
  static bool isExtraLargeScreen(BuildContext context) => MediaQuery.sizeOf(context).width >= 1400;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    if (size.width >= 1100) return desktop;
    if (size.width >= 850 && tablet != null) return tablet!;
    return mobile;
  }
}

// =============================================================================
// 4. MOCK SECTIONS
// =============================================================================
class _PlaceholderPage extends StatelessWidget {
  final String title;
  final Color color;
  const _PlaceholderPage(this.title, this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withValues(alpha: 0.5))),
      child: Center(child: Text(title, style: TextStyle(fontSize: 32, color: color, fontWeight: FontWeight.bold))),
    );
  }
}

class MainViewWrapper extends StatelessWidget {
  const MainViewWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return const MainView(pages: [
      _PlaceholderPage("Home View", Colors.blueAccent),
      _PlaceholderPage("Search View", Colors.greenAccent),
      _PlaceholderPage("Favorites View", Colors.orangeAccent),
      _PlaceholderPage("Settings View", Colors.purpleAccent),
      _PlaceholderPage("Profile View", Colors.redAccent),
    ]);
  }
}

class CustomDrawer extends StatelessWidget { const CustomDrawer({super.key}); @override Widget build(BuildContext context) => const Drawer(child: Center(child: Text("Drawer Content", style: TextStyle(color: Colors.white)))); }
class MeshBackground extends StatelessWidget { final ScrollController scrollController; const MeshBackground({super.key, required this.scrollController}); @override Widget build(BuildContext context) => const SizedBox.shrink(); }
class PluginsSection extends StatelessWidget { const PluginsSection({super.key}); @override Widget build(BuildContext context) => const SizedBox.shrink(); }
class FeaturedVideos extends StatelessWidget { const FeaturedVideos({super.key}); @override Widget build(BuildContext context) => const SizedBox.shrink(); }
class ShortsVibes extends StatelessWidget { const ShortsVibes({super.key}); @override Widget build(BuildContext context) => const SizedBox.shrink(); }
class CollegeMemories extends StatelessWidget { const CollegeMemories({super.key}); @override Widget build(BuildContext context) => const SizedBox.shrink(); }
class PortfolioEnding extends StatelessWidget { const PortfolioEnding({super.key}); @override Widget build(BuildContext context) => const _PlaceholderPage("End of Content", Colors.deepPurple); }
class NavigationButtonList extends StatelessWidget { const NavigationButtonList({super.key}); @override Widget build(BuildContext context) => Row(children: [TextButton(onPressed: () => appController.scrollToSection(AppController.section1Key), child: const Text("Home", style: TextStyle(color: Colors.white))), TextButton(onPressed: () => appController.scrollToSection(AppController.section2Key), child: const Text("Search", style: TextStyle(color: Colors.white)))]); }

// =============================================================================
// 5. TOP NAVIGATION BAR (For Desktop)
// =============================================================================
class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  bool _isHovered = false;
  bool _isLogoHovered = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final bool showFullNav = width >= 1100;

    return Obx(() {
      final bool isMenuOpen = appController.isMenuOpen.value;

      return AnimatedBuilder(
        animation: appController.scrollController,
        builder: (context, child) {
          final double offset = appController.scrollController.hasClients
              ? appController.scrollController.offset
              : 0;

          final bool isScrolled = offset > 50;
          final double glassOpacity = isScrolled ? 0.65 : 0.2;
          final double blurAmount = isScrolled ? 24.0 : 12.0;
          final double horizontalPadding = showFullNav ? AppConstants.spacing24 : 16.0;
          final double topMargin = isScrolled ? 0.0 : 0.0;

          return Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              margin: EdgeInsets.only(
                  top: topMargin,
                  left: isMenuOpen ? 12.0 : AppConstants.spacing24,
                  right: isMenuOpen ? 12.0 : AppConstants.spacing24),
              height: 72,
              constraints: BoxConstraints(maxWidth: isMenuOpen ? 1100 : 1200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .shadowColor
                        .withValues(alpha: isScrolled ? 0.15 : 0.05),
                    blurRadius: isScrolled ? 30 : 15,
                    offset: Offset(0, isScrolled ? 15 : 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.15),
                        width: 1.2,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withValues(alpha: glassOpacity),
                          Theme.of(context)
                              .scaffoldBackgroundColor
                              .withValues(alpha: glassOpacity * 0.8),
                        ],
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildLogo(),

                        if (showFullNav)
                          const Expanded(
                            child: Center(child: NavigationButtonList()),
                          ),

                        if (!showFullNav) const Spacer(),

                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildAdminButton(),
                                const SizedBox(width: 8),
                                _buildHireMeButton(context),
                              ],
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
        },
      );
    });
  }

  Widget _buildLogo() {
    return MouseRegion(
      onEnter: (_) => setState(() => _isLogoHovered = true),
      onExit: (_) => setState(() => _isLogoHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => appController.scrollToTop(),
        child: AnimatedRotation(
          turns: _isLogoHovered ? 0.05 : 0,
          duration: const Duration(milliseconds: 300),
          child: const SizedBox(
            height: 45,
            child: Icon(Icons.code, size: 40, color: Colors.white), 
          ),
        ),
      ),
    );
  }

  Widget _buildHireMeButton(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
      }),
      cursor: SystemMouseCursors.click,
      child: PopupMenuButton<String>(
        tooltip: 'Contact',
        offset: const Offset(0, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: AppConstants.cardColor,
        onSelected: (value) async {
          const email = 'contact@example.com';
          const subject = 'Inquiry';
          if (value == 'gmail') {
            final gmailUrl = Uri(
                scheme: 'https',
                host: 'mail.google.com',
                path: '/mail/',
                queryParameters: {
                  'view': 'cm',
                  'fs': '1',
                  'to': email,
                  'su': subject
                });
            final mailtoUrl = Uri(
                scheme: 'mailto',
                path: email,
                queryParameters: {'subject': subject});
            if (!await launchUrl(mailtoUrl)) {
              await launchUrl(gmailUrl, mode: LaunchMode.externalApplication);
            }
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'gmail',
            child: Row(children: [
              Icon(Icons.email, color: Colors.redAccent),
              SizedBox(width: 10),
              Text('Gmail', style: TextStyle(color: Colors.white))
            ]),
          ),
        ],
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          transform: Matrix4.diagonal3Values(
            _isHovered ? 1.05 : 1.0,
            _isHovered ? 1.05 : 1.0,
            1.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xFFFF4D8D), Color(0xFF6C7BFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C7BFF)
                    .withValues(alpha: _isHovered ? 0.6 : 0.4),
                blurRadius: _isHovered ? 20 : 12,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: const Text(
            "Contact",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ),
    );
  }

  Offset _adminMagneticOffset = Offset.zero;

  Widget _buildAdminButton() {
    return MouseRegion(
      onExit: (_) => setState(() {
        _adminMagneticOffset = Offset.zero;
      }),
      onHover: (event) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final Offset center = box.size.center(Offset.zero);
          final Offset localPos = event.localPosition;
          setState(() {
            _adminMagneticOffset = Offset(
              (localPos.dx - center.dx) * 0.1,
              (localPos.dy - center.dy) * 0.1,
            );
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(
            _adminMagneticOffset.dx, _adminMagneticOffset.dy, 0),
        child: IconButton(
          icon: Icon(Icons.admin_panel_settings,
              color: Theme.of(context).colorScheme.primary),
          onPressed: () {},
          tooltip: 'Admin Dashboard',
        ),
      ),
    );
  }
}

// =============================================================================
// 6. MAIN VIEW (Integrating the Package)
// =============================================================================
class MainView extends StatelessWidget {
  const MainView({super.key, required this.pages});

  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    Get.put(PortfolioController());

    final bool isDesktop = Responsive.isDesktop(context);
    final bool isLarge = Responsive.isExtraLargeScreen(context);

    return Scaffold(
      backgroundColor: AppConstants.bgColor,
      drawer: isDesktop ? null : const CustomDrawer(),
      body: Row(
        children: [
          if (isDesktop)
            Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic,
                  width: appController.isMenuOpen.value
                      ? (isLarge ? 320 : 280)
                      : 0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      if (appController.isMenuOpen.value)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      width: isLarge ? 320 : 280,
                      child: const CustomDrawer(),
                    ),
                  ),
                )),
          Expanded(
            child: Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubic,
                  margin: appController.isMenuOpen.value
                      ? const EdgeInsets.only(
                          top: 0, left: 12, right: 12, bottom: 12)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: AppConstants.bgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          appController.isMenuOpen.value ? 24 : 0),
                      topRight: Radius.circular(
                          appController.isMenuOpen.value ? 24 : 0),
                      bottomLeft: Radius.circular(
                          appController.isMenuOpen.value ? 24 : 0),
                      bottomRight: Radius.circular(
                          appController.isMenuOpen.value ? 24 : 0),
                    ),
                    boxShadow: [
                      if (appController.isMenuOpen.value)
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.04),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          appController.isMenuOpen.value ? 24 : 0),
                      topRight: Radius.circular(
                          appController.isMenuOpen.value ? 24 : 0),
                      bottomLeft: Radius.circular(
                          appController.isMenuOpen.value ? 24 : 0),
                      bottomRight: Radius.circular(
                          appController.isMenuOpen.value ? 24 : 0),
                    ),
                    child: Stack(
                      children: [
                        if (isDesktop)
                          RepaintBoundary(
                            child: MeshBackground(
                                scrollController: globalScrollController),
                          ),
                        if (isDesktop) const _MouseHalo(),
                        Builder(
                          builder: (context) {
                            final List<Widget> sections = [
                              _buildSection(AppController.section1Key, pages[0]),
                              _SectionDivider(isDesktop: isDesktop),
                              _buildSection(AppController.section2Key, pages[1]),
                              _SectionDivider(isDesktop: isDesktop),
                              _buildSection(AppController.section3Key, pages[2]),
                              _SectionDivider(isDesktop: isDesktop),
                              _buildSection(AppController.section4Key, pages[3]),
                              _SectionDivider(isDesktop: isDesktop),
                              _buildSection(AppController.section5Key, pages[4]),
                              _SectionDivider(isDesktop: isDesktop),
                              const PortfolioEnding(),
                              if (!isDesktop)
                                Obx(() => SizedBox(
                                      height: appController.isNavbarVisible.value ? 100 : 20,
                                    )),
                            ];

                            return ListView.builder(
                              controller: globalScrollController,
                              physics: const BouncingScrollPhysics(),
                              cacheExtent: 2000,
                              addAutomaticKeepAlives: true,
                              addRepaintBoundaries: true,
                              padding: EdgeInsets.zero,
                              itemCount: sections.length,
                              itemBuilder: (context, index) {
                                final sectionWidget = sections[index];

                                final isFirst = index == 0;
                                
                                return Center(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(maxWidth: 1200),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: isFirst ? (isDesktop ? 80 : 40) : 0,
                                      ),
                                      child: (sectionWidget is _SectionDivider || sectionWidget is SizedBox)
                                          ? sectionWidget
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: isDesktop ? AppConstants.spacing64 : AppConstants.spacing24,
                                              ),
                                              child: _DynamicSection(
                                                index: index,
                                                animKey: 'section_anim_$index',
                                                child: sectionWidget,
                                              ),
                                            ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),

                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Obx(() => AnimatedSlide(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOutCubic,
                                offset: appController.isHeaderVisible.value
                                    ? Offset.zero
                                    : const Offset(0, -1.5), 
                                child: SafeArea(
                                  bottom: false,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: isDesktop ? 0 : 2), 
                                    child: const RepaintBoundary(
                                        child: TopNavigationBar()),
                                  ),
                                ),
                              )),
                        ),
                        if (!isDesktop)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Obx(() {
                              return AnimatedSlide(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOutCubic,
                                offset: appController.isNavbarVisible.value
                                    ? Offset.zero
                                    : const Offset(0, 1.5),
                                child: MediaQuery.removePadding(
                                  context: context,
                                  removeBottom: true,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.85),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, -2),
                                        ),
                                      ],
                                    ),
                                    // THIS IS THE PACKAGE WIDGET:
                                    child: AnimatedNotchBottomBar(
                                      notchBottomBarController:
                                          appController.notchBottomBarController,
                                      color: AppConstants.cardColor,
                                      showLabel: true,
                                      notchColor: AppConstants.darkColor,
                                      removeMargins: true,
                                      bottomBarHeight: 72.0,
                                      activeIconColor: AppConstants.activeIconColor,
                                      
                                      bottomBarItems: const [
                                        BottomBarItem(
                                          inActiveItem: Icon(Icons.home_outlined,
                                              color: Colors.white60),
                                          activeItem: Icon(Icons.home_filled),
                                          itemLabel: 'Home',
                                        ),
                                        BottomBarItem(
                                          inActiveItem: Icon(Icons.search_outlined,
                                              color: Colors.white60),
                                          activeItem: Icon(Icons.search),
                                          itemLabel: 'Search',
                                        ),
                                        BottomBarItem(
                                          inActiveItem: Icon(Icons.favorite_outline,
                                              color: Colors.white60),
                                          activeItem: Icon(Icons.favorite),
                                          itemLabel: 'Favorites',
                                        ),
                                        BottomBarItem(
                                          inActiveItem: Icon(Icons.settings_outlined,
                                              color: Colors.white60),
                                          activeItem: Icon(Icons.settings),
                                          itemLabel: 'Settings',
                                        ),
                                        BottomBarItem(
                                          inActiveItem: Icon(Icons.person_outline,
                                              color: Colors.white60),
                                          activeItem: Icon(Icons.person),
                                          itemLabel: 'Profile',
                                        ),
                                      ],
                                      onTap: (index) {
                                        appController.notchBottomBarController
                                            .jumpTo(index);
                                        switch (index) {
                                          case 0:
                                            appController.scrollToSection(
                                                AppController.section1Key);
                                            break;
                                          case 1:
                                            appController.scrollToSection(
                                                AppController.section2Key);
                                            break;
                                          case 2:
                                            appController.scrollToSection(
                                                AppController.section3Key);
                                            break;
                                          case 3:
                                            appController.scrollToSection(
                                                AppController.section4Key);
                                            break;
                                          case 4:
                                            appController.scrollToSection(
                                                AppController.section5Key);
                                            break;
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        
                        Positioned(
                          bottom: isDesktop ? 40 : 60,
                          right: isDesktop ? 40 : 30,
                          child: Obx(() => AnimatedScale(
                                duration: const Duration(milliseconds: 500),
                                scale: !appController.isNavbarVisible.value ? 1.0 : 0.0,
                                curve: Curves.easeOutBack,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => appController.scrollToTop(),
                                    child: Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: AppConstants.bgColor,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: AppConstants.activeIconColor
                                              .withValues(alpha: 0.5),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppConstants.activeIconColor
                                                .withValues(alpha: 0.25),
                                            blurRadius: 15,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 5),
                                          ),
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.5),
                                            blurRadius: 10,
                                            spreadRadius: -2,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.arrow_upward_rounded,
                                        color: AppConstants.activeIconColor,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(GlobalKey key, Widget child) {
    return SizedBox(key: key, child: child);
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.isDesktop});
  final bool isDesktop;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? AppConstants.spacing64 : AppConstants.spacing24,
        vertical: isDesktop ? 80.0 : 40.0,
      ),
      child: isDesktop
          ? const Divider(color: Colors.white12, thickness: 1)
          : const SizedBox.shrink(),
    );
  }
}

class _MouseHalo extends StatefulWidget {
  const _MouseHalo();
  @override
  State<_MouseHalo> createState() => _MouseHaloState();
}

class _MouseHaloState extends State<_MouseHalo> {
  final ValueNotifier<Offset> _mousePos = ValueNotifier(Offset.zero);
  @override
  void dispose() {
    _mousePos.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      onHover: (event) => _mousePos.value = event.position,
      child: ValueListenableBuilder<Offset>(
        valueListenable: _mousePos,
        builder: (context, pos, child) {
          return Transform.translate(
            offset: pos + const Offset(-200, -200),
            child: child!,
          );
        },
        child: IgnorePointer(
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppConstants.primaryColor.withValues(alpha: 0.12),
                  AppConstants.secondaryColor.withValues(alpha: 0.05),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DynamicSection extends StatefulWidget {
  final Widget child;
  final String animKey;
  final int index;
  const _DynamicSection({
    required this.child,
    required this.animKey,
    required this.index,
  });
  @override
  State<_DynamicSection> createState() => _DynamicSectionState();
}

class _DynamicSectionState extends State<_DynamicSection> {
  bool _isVisible = false;
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.animKey),
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction > 0.1) {
          if (mounted) {
            setState(() {
              _isVisible = true;
            });
            final String sectionName = widget.animKey;
            Get.find<PortfolioController>().trackAction('view_$sectionName');
          }
        }
      },
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: globalScrollController,
          builder: (context, child) {
            double tiltAngle = 0.0;
            double scale = 1.0;

            if (_isVisible && globalScrollController.hasClients) {
              final RenderBox? box = _key.currentContext?.findRenderObject() as RenderBox?;
              if (box != null) {
                final position = box.localToGlobal(Offset.zero);
                final screenHeight = MediaQuery.sizeOf(context).height;
                final centerY = position.dy + (box.size.height / 2);
                
                if (centerY > -500 && centerY < screenHeight + 500) {
                  final double distance = ((centerY - (screenHeight / 2)) / (screenHeight / 2)).clamp(-1.0, 1.0);
                  tiltAngle = distance * 0.03; 
                  scale = 1.0 - (distance.abs() * 0.012);
                }
              }
            }

            return Transform(
              key: _key,
              transform: Matrix4.diagonal3Values(scale, scale, 1.0)
                ..setEntry(3, 2, 0.0008)
                ..rotateX(tiltAngle),
              alignment: Alignment.center,
              child: child,
            );
          },
          child: _isVisible
              ? RepaintBoundary(child: _applyUniqueAnimation(widget.child, widget.index))
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _applyUniqueAnimation(Widget child, int index) {
    final anim =
        child.animate().fadeIn(duration: 800.ms, curve: Curves.easeOut);

    switch (index % 4) {
      case 0: 
        return anim
            .slideX(begin: -0.4, end: 0, curve: Curves.easeOutBack)
            .scale(begin: const Offset(0.7, 0.7), curve: Curves.easeOutBack)
            .shimmer(duration: 1200.ms, color: Colors.white24);
      case 2: 
        return anim
            .slideX(begin: 0.4, end: 0, curve: Curves.easeOutBack)
            .scale(begin: const Offset(0.7, 0.7), curve: Curves.easeOutBack)
            .shimmer(duration: 1200.ms, color: Colors.white24);
      case 1:
      case 3: 
      default:
        return anim
            .slideY(begin: 0.4, end: 0, curve: Curves.easeOutBack)
            .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);
    }
  }
}
