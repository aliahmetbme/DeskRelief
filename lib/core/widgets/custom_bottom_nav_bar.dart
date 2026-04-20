import 'dart:ui';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CustomBottomNavBar — M-Tech Rectangle Edition
// Features: Rectangle Rounded Indicator, Interactive Drag, Ultra-Low Floating.
// ─────────────────────────────────────────────────────────────────────────────
class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  bool _isDragging = false;
  double _dragAlignmentX = 0; // Manual alignment during drag (-1.0 to 1.0)

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    // Standard M-Tech Color: Neon/Medical Blue
    const medicalBlue = Color.fromARGB(255, 73, 220, 253);

    return Container(
      width: screenWidth,
      // Reduced bottom padding to bring it closer to the screen bottom
      padding: EdgeInsets.fromLTRB(
        10, // Wider bar by reducing side padding
        0,
        10,
        bottomPadding > 0 ? bottomPadding : 10,
      ),
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          setState(() {
            _isDragging = true;
            // Initialize drag alignment to current item position
            _dragAlignmentX = -1.0 + (widget.currentIndex * (2.0 / 2));
          });
        },
        onHorizontalDragUpdate: (details) {
          setState(() {
            // Convert pixels to Alignment X scale (-1.0 to 1.0)
            final deltaAlignment = details.primaryDelta! / ((screenWidth - 20) / 2);
            _dragAlignmentX = (_dragAlignmentX + deltaAlignment).clamp(-1.0, 1.0);
          });
        },
        onHorizontalDragEnd: (details) {
          setState(() {
            _isDragging = false;
            // Snap to closest index
            int targetIndex = ((_dragAlignmentX + 1.0) / 2 * 2).round().clamp(0, 2);
            widget.onTap(targetIndex);
          });
        },
        child: SizedBox(
          height: 76,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // ─── Main Pill Background ──────────────────────────────────────
              _MainPillBackground(isDark: isDark),

              // ─── The Rounded Rectangle Indicator (Lens) ───────────────────
              _MTechRectIndicator(
                currentIndex: widget.currentIndex,
                manualAlignmentX: _dragAlignmentX,
                isDragging: _isDragging,
                totalItems: 3,
                isDark: isDark,
                accentColor: medicalBlue,
              ),

              // ─── Navigation Items ─────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    index: 0,
                    currentIndex: widget.currentIndex,
                    icon: Icons.grid_view_rounded,
                    activeIcon: Icons.grid_view_rounded,
                    label: 'Ana Sayfa',
                    onTap: widget.onTap,
                  ),
                  _NavItem(
                    index: 1,
                    currentIndex: widget.currentIndex,
                    icon: Icons.event_note_rounded,
                    activeIcon: Icons.event_note_rounded,
                    label: 'Takvim',
                    onTap: widget.onTap,
                  ),
                  _NavItem(
                    index: 2,
                    currentIndex: widget.currentIndex,
                    icon: Icons.person_pin_rounded,
                    activeIcon: Icons.person_pin_rounded,
                    label: 'Profil',
                    onTap: widget.onTap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainPillBackground extends StatelessWidget {
  final bool isDark;
  const _MainPillBackground({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            decoration: BoxDecoration(
              color: (isDark ? Colors.grey.shade900 : Colors.white).withValues(
                alpha: 0.9,
              ),
              border: Border.all(
                color: (isDark ? Colors.white : Colors.black).withValues(
                  alpha: 0.12,
                ),
                width: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MTechRectIndicator extends StatelessWidget {
  final int currentIndex;
  final double manualAlignmentX;
  final bool isDragging;
  final int totalItems;
  final bool isDark;
  final Color accentColor;

  const _MTechRectIndicator({
    required this.currentIndex,
    required this.manualAlignmentX,
    required this.isDragging,
    required this.totalItems,
    required this.isDark,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final alignmentX = isDragging 
        ? manualAlignmentX 
        : -1.0 + (currentIndex * (2.0 / (totalItems - 1)));

    return AnimatedAlign(
      alignment: Alignment(alignmentX, 0.0),
      duration: Duration(milliseconds: isDragging ? 50 : 450),
      curve: Curves.easeOutQuart,
      child: FractionallySizedBox(
        widthFactor: 1 / totalItems,
        child: Center(
          child: Container(
            width: 120,
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: 0.2),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.35),
                        Colors.white.withValues(alpha: 0.05),
                        Colors.black.withValues(alpha: 0.05),
                      ],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 5,
                        left: 10,
                        child: Container(
                          width: 20,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedScale(
          scale: isActive ? 1.45 : 1.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: isActive && isDark
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.15),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ],
                      )
                    : null,
                child: Icon(
                  isActive ? activeIcon : icon,
                  color: isDark ? Colors.white : Colors.black,
                  size: 22,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                  fontFamily: 'Inter',
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
