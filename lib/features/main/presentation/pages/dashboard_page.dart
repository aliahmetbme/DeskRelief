import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:deskrelief/l10n/app_localizations.dart';

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
          // Fine-tuned: +16 padding ensures greeting isn't cut off by safe area
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).padding.top + 16),
          ),

          // ─── Content ──────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // 1. Welcome Section
                const _WelcomeSection(),
                const SizedBox(height: 28),

                // 2. Progress Section
                const _ProgressSection(),
                const SizedBox(height: 24),

                // 3. Clinical Warning
                const _ClinicalWarningSection(),
                const SizedBox(height: 24),

                const _DailyProgramHero(),
                const SizedBox(height: 24),

                // 4. Clinical Info Card
                const _ClinicalInfoCard(),
                const SizedBox(height: 32),

                // 5. Spinal Health Tips
                const _SpinalHealthTipsHeader(),
                const SizedBox(height: 16),
                const _TipsGrid(),
                const SizedBox(height: 32),

                // Footer spacing for Bottom Nav Bar
                const SizedBox(height: 120),
              ]),
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
  const _WelcomeSection();

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
              loc.greetingKeepGoing('Can Yılmaz'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.0,
                color: isDark ? Colors.white : Colors.black,
                height: 1.1,
              ),
            ),
          ],
        ),
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
  const _ProgressSection();

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
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        // 2. Status Banner (Adaptive Dynamic Pill)
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

class _TipsGrid extends StatelessWidget {
  const _TipsGrid();

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Column(
      children: [
        _TipItem(
          icon: Icons.chair_rounded,
          color: Colors.blue,
          title: loc.tipErgonomicsTitle,
          subtitle: loc.tipErgonomicsDesc,
        ),
        const SizedBox(height: 12),
        _TipItem(
          icon: Icons.rebase_edit,
          color: Colors.green,
          title: loc.tipMobilityTitle,
          subtitle: loc.tipMobilityDesc,
        ),
        const SizedBox(height: 12),
        _TipItem(
          icon: Icons.self_improvement_rounded,
          color: Colors.purple,
          title: loc.tipLowerBackTitle,
          subtitle: loc.tipLowerBackDesc,
        ),
      ],
    );
  }
}

class _TipItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const _TipItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.3,
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

class _DailyProgramHero extends StatelessWidget {
  const _DailyProgramHero();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
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
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primary, primary.withValues(alpha: 0.8)],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
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
                      style: const TextStyle(
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
            ),
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
            subtitle,
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 10,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
