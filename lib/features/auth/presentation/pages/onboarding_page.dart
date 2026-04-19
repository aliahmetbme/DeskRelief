import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Is Sitting Causing You Pain?',
      'description':
          'The modern office lifestyle often leads to prolonged sitting, which can cause significant neck, back, and shoulder pain.',
      'image': 'assets/images/onboarding1.png',
      'textAlign': TextAlign.center,
    },
    {
      'title': 'Meet DeskRelief, Your Digital Solution',
      'description':
          'DeskRelief offers expert-curated, personalized exercise protocols designed to interrupt sitting intervals and minimize pain.',
      'image': 'assets/images/onboarding2.png',
      'textAlign': TextAlign.center,
    },
    {
      'title': 'Take Control of Your Musculoskeletal Health',
      'description':
          'Start your personalized journey towards a pain-free life. It\'s easy and clinically-based.',
      'image': 'assets/images/onboarding3.png',
      'textAlign': TextAlign.center,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (!mounted) return;
    context.go('/signup');
  }

  void _onNextPressed() {
    if (_currentPage == _pages.length - 1) {
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
    bool isLastPage = _currentPage == _pages.length - 1;

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
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Top 65%: Image Background
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(_pages[index]['image'], fit: BoxFit.cover),
                        // Tonal Overlay (Back/Skip butonlarının görünürlüğü için)
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black26,
                                Colors.transparent,
                                Colors.transparent,
                              ],
                              stops: [0.0, 0.3, 1.0],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom 45%: Content Card
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 40,
                            offset: Offset(0, -10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.only(
                        left: 32,
                        right: 32,
                        top: 40,
                        bottom: 48,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            _pages[index]['textAlign'] == TextAlign.center
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            _pages[index]['title'],
                            textAlign: _pages[index]['textAlign'],
                            style: theme.textTheme.displayLarge,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            _pages[index]['description'],
                            textAlign: _pages[index]['textAlign'],
                            style: theme.textTheme.bodyLarge,
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
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: theme.colorScheme.primary,
                        ),
                        onPressed: _onPreviousPressed,
                      )
                    : const SizedBox(
                        width: 48,
                      ), // Padding equivalent to keep Skip on right
                // Skip Button (Not on the last page)
                !isLastPage
                    ? GestureDetector(
                        onTap: _completeOnboarding,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Skip',
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),

          // Bottom Controls (Dots & Next Button OR Start Button)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 48,
            left: 32,
            right: 32,
            child: isLastPage
                ? // Page 3: Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _onNextPressed,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Get Started'),
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
                    height: 48, // Dokunma alanı için
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Dots
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              _pages.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.only(right: 8),
                                height: 8,
                                width: _currentPage == index ? 32 : 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Next Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: _onNextPressed,
                            child: Container(
                              color: Colors.transparent, // Dokunma alanı için
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Next',
                                    style: theme.textTheme.labelLarge,
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.chevron_right,
                                    color: theme.colorScheme.primary,
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
    );
  }
}
