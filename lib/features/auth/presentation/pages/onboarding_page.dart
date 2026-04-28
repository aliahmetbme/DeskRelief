import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/widgets/app_back_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, dynamic>> _getPages(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      {
        'title': l10n.onboardingTitle1,
        'description': l10n.onboardingDesc1,
        'image': 'assets/images/onboarding1.png',
        'textAlign': TextAlign.center,
      },
      {
        'title': l10n.onboardingTitle2,
        'description': l10n.onboardingDesc2,
        'image': 'assets/images/onboarding2.png',
        'textAlign': TextAlign.center,
      },
      {
        'title': l10n.onboardingTitle3,
        'description': l10n.onboardingDesc3,
        'image': 'assets/images/onboarding3.png',
        'textAlign': TextAlign.center,
      },
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (!mounted) return;
    context.go('/signin');
  }

  void _onNextPressed(int pageCount) {
    if (_currentPage == pageCount - 1) {
      _completeOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPreviousPressed() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final pages = _getPages(context);
    bool isLastPage = _currentPage == pages.length - 1;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Swipeable content (Image + Card)
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Top 65%: Image Background
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height * 0.72,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(pages[index]['image'], fit: BoxFit.cover),
                        // Tonal Overlay (Back/Skip butonlarının görünürlüğü için)
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black45,
                                Colors.black12,
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.3, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    // Use a flexible height with a minimum threshold
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.42,
                        maxHeight: MediaQuery.of(context).size.height * 0.48,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 40,
                            offset: Offset(0, -10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Scrollable Text Content
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 40,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    pages[index]['textAlign'] == TextAlign.center
                                    ? CrossAxisAlignment.center
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pages[index]['title'],
                                    textAlign: pages[index]['textAlign'],
                                    style: theme.textTheme.displayLarge,
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    pages[index]['description'],
                                    textAlign: pages[index]['textAlign'],
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Navigation Controls (Fixed at the bottom of the card)
                          Padding(
                            padding: EdgeInsets.only(
                              left: 32,
                              right: 32,
                              bottom: MediaQuery.of(context).padding.bottom + 24,
                              top: 12,
                            ),
                            child: index == pages.length - 1
                                ? // Page 3: Get Started Button
                                  SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton(
                                      onPressed: () => _onNextPressed(pages.length),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(28),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(l10n.getStarted),
                                          const SizedBox(width: 8),
                                          const Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : // Page 1 & 2: Dots and Next Button
                                  SizedBox(
                                    height: 48,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Dots
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: List.generate(
                                              pages.length,
                                              (dotIndex) => AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                margin: const EdgeInsets.only(
                                                    right: 8),
                                                height: 8,
                                                width: index == dotIndex ? 32 : 8,
                                                decoration: BoxDecoration(
                                                  color: index == dotIndex
                                                      ? theme.colorScheme.primary
                                                      : theme.colorScheme.secondary,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Next Button
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: () => _onNextPressed(pages.length),
                                            child: Container(
                                              color: Colors.transparent,
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    l10n.next,
                                                    style: theme
                                                        .textTheme.labelLarge,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Icon(
                                                    Icons.chevron_right,
                                                    color: theme
                                                        .colorScheme.primary,
                                                    size: 24,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Top Navigation (Back & Skip Buttons)
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button (Not on the first page)
                _currentPage > 0
                    ? AppBackButton(onTap: _onPreviousPressed)
                    : const SizedBox(width: 48),
                // Skip Button (Not on the last page)
                !isLastPage
                    ? GestureDetector(
                        onTap: _completeOnboarding,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            l10n.skip,
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
