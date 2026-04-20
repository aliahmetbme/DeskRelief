import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_bottom_nav_bar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MainLayoutPage — Advanced Swipable Shell Layout
// Uses PageView to allow horizontal swiping between branches.
// ─────────────────────────────────────────────────────────────────────────────
class MainLayoutPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  const MainLayoutPage({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.navigationShell.currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  void didUpdateWidget(MainLayoutPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync PageController if index changed from outside (e.g. deep link)
    if (_pageController.hasClients &&
        _pageController.page?.round() != widget.navigationShell.currentIndex) {
      _pageController.animateToPage(
        widget.navigationShell.currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutQuart,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: widget.children,
        onPageChanged: (index) {
          // Sync shell branch when user swipes
          if (index != widget.navigationShell.currentIndex) {
            widget.navigationShell.goBranch(index);
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
