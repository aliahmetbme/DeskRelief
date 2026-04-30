import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:deskrelief/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../viewmodels/dashboard_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DashboardPage — High-fidelity Dashboard based on premium mockup
// ─────────────────────────────────────────────────────────────────────────────
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── Header Spacing ──────────────────────────────────────────────
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.top + 16),
          ),
          // ─── Content ──────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            sliver: Consumer<DashboardViewModel>(
              builder: (context, viewModel, child) {
                final isRestDay = false; //viewModel.isRestDay;

                return SliverList(
                  delegate: SliverChildListDelegate([
                    // 1. Welcome Section
                    _WelcomeSection(isRestDay: isRestDay),
                    const SizedBox(height: 28),

                    // 2. Progress Section
                    _ProgressSection(isRestDay: isRestDay),
                    const SizedBox(height: 24),

                    if (isRestDay) ...[
                      // 3. Rest Day Clinical Card
                      const _RestDayClinicalCard(),
                      const SizedBox(height: 20),

                      // 4. Next Session Card
                      const _NextSessionCard(),
                      const SizedBox(height: 32),

                      // 5. Spinal Health Tips (Bento Grid)
                      const _SpinalHealthTipsHeader(),
                      const SizedBox(height: 16),
                      const _BentoTipsGrid(),
                    ] else ...[
                      // 3. Clinical Warning
                      const _ClinicalWarningSection(),
                      const SizedBox(height: 24),

                      const _DailyProgramHero(),
                      const SizedBox(height: 24),

                      // 4. Clinical Info Card
                      const _ClinicalInfoCard(),
                    ],

                    const SizedBox(height: 32),

                    // Footer spacing for Bottom Nav Bar
                    const SizedBox(height: 120),
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets for Dashboard
// ─────────────────────────────────────────────────────────────────────────────

class _WelcomeSection extends StatelessWidget {
  final bool isRestDay;
  const _WelcomeSection({required this.isRestDay});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    // Dynamically format today's date based on current locale
    final localeCode = Localizations.localeOf(context).toString();
    final String today = DateFormat(
      'EEEE, d MMMM',
      localeCode,
    ).format(DateTime.now()).toUpperCase();

    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              today,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white60 : Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isRestDay
                  ? loc.restDayTitle
                  : loc.greetingKeepGoing('Can Yılmaz'),
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.0,
                color: isDark ? Colors.white : Colors.black,
                height: 1.1,
              ),
            ),
          ],
        ),
        if (!isRestDay)
          Positioned(right: -8, top: -20, child: _FlareUpButton()),
      ],
    );
  }
}

class _FlareUpButton extends StatefulWidget {
  @override
  State<_FlareUpButton> createState() => _FlareUpButtonState();
}

class _FlareUpButtonState extends State<_FlareUpButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _isPressed
              ? Colors.red.withValues(alpha: 0.35)
              : Colors.red.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: _isPressed
                ? Colors.red.withValues(alpha: 0.6)
                : Colors.red.withValues(alpha: 0.2),
          ),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.red.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.local_fire_department_rounded,
              color: _isPressed ? const Color(0xFFB71C1C) : Colors.redAccent,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              loc.flareUp,
              style: TextStyle(
                color: _isPressed ? const Color(0xFFB71C1C) : Colors.redAccent,
                fontWeight: FontWeight.w800,
                fontSize: 13,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  final bool isRestDay;
  const _ProgressSection({required this.isRestDay});

  // Logic to determine feedback message based on progress
  String _getFeedbackMessage(BuildContext context, double progress) {
    final loc = AppLocalizations.of(context)!;
    if (progress == 0) return loc.feedbackStart;
    if (progress < 0.3) return loc.feedbackStep;
    if (progress < 0.6) return loc.feedbackHalfway;
    if (progress < 1.0) return loc.feedbackAlmostDone;
    return loc.feedbackDone;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    // In a real app, these would come from a ViewModel
    const double progressValue = 0.8;
    const int totalSessions = 5;
    final int completedSessions = (progressValue * totalSessions).toInt();
    final int remainingSessions = totalSessions - completedSessions;

    final cobaltBlue = isDark
        ? const Color(0xFF4D94FF)
        : const Color(0xFF0052CC);
    final softGreen = isDark
        ? const Color(0xFF1B3B2B)
        : const Color(0xFFDFFFD6);
    final darkGreen = isDark
        ? const Color(0xFF4ADE80)
        : const Color(0xFF1E5631);

    return Column(
      children: [
        // 1. Circular Progress Module
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: cobaltBlue.withValues(alpha: 0.08),
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 16,
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.withValues(alpha: 0.1),
              ),
            ),
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: progressValue,
                strokeWidth: 16,
                color: cobaltBlue,
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${(progressValue * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w800,
                    color: cobaltBlue,
                    letterSpacing: -2,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  loc.planCompleted,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                /* Seans mesajı kullanıcı isteği üzerine kaldırıldı */
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // 2. Status Banner (Adaptive Dynamic Pill) - Hidden in Rest Day mode
        if (!isRestDay)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: softGreen,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: darkGreen.withValues(alpha: isDark ? 0.3 : 0.1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: darkGreen,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    remainingSessions == 0 ? Icons.celebration : Icons.check,
                    color: isDark ? Colors.black : Colors.white,
                    size: 14,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    remainingSessions == 0
                        ? _getFeedbackMessage(context, progressValue)
                        : loc.feedbackRemainingSessions(
                            _getFeedbackMessage(context, progressValue),
                            remainingSessions,
                          ),
                    style: TextStyle(
                      color: darkGreen,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ClinicalWarningSection extends StatelessWidget {
  const _ClinicalWarningSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    // Modern, accessible warning colors
    final warningColor = isDark
        ? const Color(0xFFFFCC00)
        : const Color(0xFF856404);
    final warningBg = isDark
        ? const Color(0xFF2D2400)
        : const Color(0xFFFFF3CD);
    final warningBorder = isDark
        ? const Color(0xFF665200)
        : const Color(0xFFFFEEB3);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warningBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: warningBorder, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: warningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.warning_rounded, color: warningColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.clinicalWarningTitle,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: warningColor,
                    fontSize: 11,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  loc.clinicalWarningDesc,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: warningColor.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClinicalInfoCard extends StatelessWidget {
  const _ClinicalInfoCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary, primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.medical_services_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.clinicalReminderTitle,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      loc.clinicalReminderDesc,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpinalHealthTipsHeader extends StatelessWidget {
  const _SpinalHealthTipsHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          loc.spinalHealthTipsTitle,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            loc.seeAll,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _DailyProgramHero extends StatelessWidget {
  const _DailyProgramHero();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.dailyProgramTitle,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      loc.dailyProgramDesc,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    loc.statusActive,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _AnatomicalCard(
                  title: loc.regionNeck,
                  subtitle: loc.regionLabel1,
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuB1H5ulPZUOi4hQ4_vfCMwI1kSBkbdD39gmsI_0imvZvY9ajZ6pUNMwGTzu6JGoyvXnbJHcIlixXUD-w6kNVG9rvzz9f5MNk0HXgm_F9EdY1FKL8Uni_9hFrLy6Q5dnhA6xQifDqRNnoC0OxIDJPjGoyr--QiqUHd47Z0gNBY0UHXqY-4diDjhTuZwBB7GvXXRdx0a96ERxqMgJNyocMfhsTwgG9tobS78S8FVouzcOR4NSdMFvqRJ_8zUmh9r3nJAbZIvCzNPAN1s',
                ),
              ),
              Expanded(
                child: _AnatomicalCard(
                  title: loc.regionLowerBack,
                  subtitle: loc.regionLabel2,
                  imageUrl:
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuBOOU-gX3r8f79tFTQ_nRO2sIAK2OIyApWXfUssnfslDBA_eQLfKhUCGY6_3IXkCTysVC2BfcXO1LkleLz6RlthsO0OBvQjMcglmxeAfZvw68EKVhX1EkVKCvZmVE7sUpHEWiIiYjDjt_nCMuTZQ_tYvqBXUSJU-m_d59uRqPXE-8alqsaNWF9H1uU2RW3O98_zLPVftwwS7AGLzcHJ7fkFLoEI55kpv-L2V-XUn-jaFEB4V1d1FysX67VESLLYMXXHU-lwSH3dC1o',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const _StartWorkoutButton(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _AnatomicalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const _AnatomicalCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StartWorkoutButton extends StatefulWidget {
  const _StartWorkoutButton();

  @override
  State<_StartWorkoutButton> createState() => _StartWorkoutButtonState();
}

class _StartWorkoutButtonState extends State<_StartWorkoutButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final loc = AppLocalizations.of(context)!;

    final baseColor = primary;
    final darkerColor = Color.lerp(primary, Colors.black, 0.2) ?? primary;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () => context.push('/exercise/daily-routine'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _isPressed
                ? [darkerColor, darkerColor.withValues(alpha: 0.9)]
                : [baseColor, baseColor.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loc.startWorkout,
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.play_circle_fill_rounded,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}

class _RestDayClinicalCard extends StatelessWidget {
  const _RestDayClinicalCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: primary.withValues(alpha: 0.12), // Even stronger blue
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.info_rounded, color: primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.restDayClinicalLabel,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w900, // Extra bold
                    fontSize: 12,
                    letterSpacing: 1.2,
                    color: primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  loc.restDayClinicalNote,
                  style: GoogleFonts.inter(
                    fontSize: 15, // Slightly larger
                    height: 1.5,
                    fontWeight: FontWeight.w700, // Bolder
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── 4. Sıradaki Seans Kartı ──────────────────────────────────────────
class _NextSessionCard extends StatelessWidget {
  const _NextSessionCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;
    final softGreen = isDark
        ? const Color(0xFF1B3B2B)
        : const Color(0xFFE8F5E9);
    final darkGreen = isDark
        ? const Color(0xFF4ADE80)
        : const Color(0xFF1B5E20);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: softGreen,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: darkGreen.withValues(alpha: isDark ? 0.2 : 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? darkGreen.withValues(alpha: 0.2) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                if (!isDark)
                  BoxShadow(
                    color: darkGreen.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Icon(
              Icons.calendar_today_rounded,
              color: darkGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loc.nextSession,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 1.0,
                    color: theme.colorScheme.onSurface.withValues(
                      alpha: 0.8,
                    ), // Darker label
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${loc.tomorrow} 19:00',
                  style: GoogleFonts.manrope(
                    fontSize: 22, // Larger
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.4,
            ), // More prominent chevron
          ),
        ],
      ),
    );
  }
}

class _BentoTipsGrid extends StatelessWidget {
  const _BentoTipsGrid();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Column(
      children: [
        // 1. Büyük Resimli Kart (Ergonomics)
        Container(
          height: 190,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            image: const DecorationImage(
              image: NetworkImage(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCzQWxMFfUgW9SVEuKg7PIsCbHl7u93Ov_mc69txVnFaw45MIKcJO_Czpg3-iFKP1Z8C4R5c8pSNTvBWXHSekRTZLv46COa25eaj3kGBD1vGpdLNPYAQng0vXc3rMxzaXJ_dYQiBsnhh5i_6N5-NGNMtzhIZn0kE5UxFq9qr6ojuf5fLFpTcWqy44UWW8flzVTtofLYtEvHVnWVlRDutVPiueTuIkKGRSAqrcxTT5xc6ErQoBePiw6QqHxLrC8DuCkRFmA_DusTPrs',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.85),
                ],
              ),
            ),
            padding: const EdgeInsets.all(24),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'REHBER',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  loc.tipErgonomicsTitle,
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // 2. Yan Yana Küçük Kartlar
        Row(
          children: [
            Expanded(
              child: _SmallBentoCard(
                icon: Icons.accessibility_new_rounded,
                title: loc.tipMobilityTitle,
                subtitle: loc.tipMobilityDesc,
                iconColor: Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _SmallBentoCard(
                icon: Icons.healing_rounded,
                title: loc.tipLowerBackTitle,
                subtitle: loc.tipLowerBackDesc,
                iconColor: Colors.orange,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SmallBentoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const _SmallBentoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 140, // Biraz daha yükseltildi
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
